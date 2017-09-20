package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxStrip;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import haxe.Timer;
import source.Global;
import flixel.util.FlxColor;



class PlayState extends FlxState
{
	private var coordX:Float;
	private var coordY:Float;
	private var coordXs:Float;
	private var coordYs:Float;
	private var enemyGroup:FlxTypedGroup<Enemy>;
	private var structGroup:FlxTypedGroup<FlxSprite>;
	private var p1:Player;
	private var ovni:SpecialEnemy;
	private var enemy1:Enemy;
	private var struct:FlxSprite;
	private var specialEnemy:SpecialEnemy;
	private var enemyToLeft:Bool;
	private var enemyRandom:FlxRandom;
	private var ovniRandom:FlxRandom;
	private var enemyToDown:Bool;
	private var textoScore:FlxText;
	private var textohScore:FlxText;
	private var textoLives:FlxText;
	private var contador:Int;
	private var deathTimer:Int;
	
	override public function create():Void
	{
		super.create();
		enemyGroup = new FlxTypedGroup<Enemy>();
		structGroup = new FlxTypedGroup<FlxSprite>();
		p1 = new Player(19, 14, AssetPaths.Personaje__png);
		ovni = new SpecialEnemy( -20, 5, AssetPaths.alienGrande__png);
		enemyToLeft = false;
		enemyRandom = new FlxRandom(0);
		ovniRandom = new FlxRandom(0);
		coordX = 13;
		coordY = 9;
		coordXs = 12;
		coordYs = 109;		
		contador = 0;
		deathTimer = 0;
		ScoreTextDraw();
		HscoreTextDraw();
		LivesTextDraw();
		
		add(ovni);
		ovni.kill();
		add(p1);
		FlxG.camera.bgColor = 0xFF1E00FF;
		
		for (i in 0...4)  // Instanciacion estructuras 
		{
			for (j in 0...2)
			{
				struct = new FlxSprite(coordXs, coordYs, AssetPaths.CuartoDeMuro__png);
				structGroup.add(struct);
				struct = new FlxSprite(coordXs, coordYs+4, AssetPaths.CuartoDeMuro__png);
				structGroup.add(struct);
				coordXs += 12;
			}
			coordXs += 12;
		}
		
		for (i in 0 ... 8) // Instanciacion grupo de enemigos
		{
			enemy1 = new Enemy(coordX, coordY, AssetPaths.marcianito__png);
			enemyGroup.add(enemy1);		
			enemy1 = new Enemy(coordX, coordY+11, AssetPaths.Marcianito2__png);
			enemyGroup.add(enemy1);		
			enemy1 = new Enemy(coordX, coordY+22, AssetPaths.Marcianito3__png);
			enemyGroup.add(enemy1);
			coordX += 14;			
		}
		
		add(enemyGroup);
		add(structGroup);
		
		FlxG.sound.playMusic(AssetPaths.Maintreme__wav);
	}

	override public function update(elapsed:Float):Void
	{		
		super.update(elapsed);
		PlayerLives();
		ShootCountdown();
		OvniSpawn();
		EnemyMovement();
		Collides();		
		CheckHighScore();
	}
	

	function CheckHighScore() // Highscore
	{
		if (Global.score > Global.hScore) 
		{
			Global.hScore = Global.score;
			textohScore.destroy();
			textohScore = new FlxText(85, 0, 0, "HighScore:" + Global.hScore, 8);
			add(textohScore);
		}
	}
	
	function ShootCountdown():Void // Conteo para el disparo aleatorio
	{
		if (contador == 40 - (Global.difficult*5))
		{
			if (enemyGroup.countLiving() != -1)
				enemyGroup.getRandom().shoot();
			contador = 0;
		}
		else
			contador++;
	}
	
	function EnemyMovement():Void // Movimiento del grupo de enemigos
	{
		for (enemy in enemyGroup)
		{
			if (enemy.x > FlxG.width - enemy.width)
			{
				enemyToLeft = true;      	
				enemyToDown = true;
			}
			if (enemy.x < 0)
			{
				enemyToLeft = false;
				enemyToDown = true;
			}
		}
		
		if (enemyToDown == true)
		{
			for (enemy in enemyGroup)
			enemy.y += 10;
		}
		
		enemyToDown = false;
		
		if (enemyToLeft == false)	
		{
			for (enemy in enemyGroup)
			enemy.x += 0.3 + (Global.difficult/7);
		}
		else 
		{
			for (enemy in enemyGroup)
			enemy.x -= 0.3 + (Global.difficult/7);
		}
		
	}
	
	function Collides():Void // Colisiones
	{	
		for (enemy in enemyGroup)
		{
			if (FlxG.overlap(enemy.bullet, p1) || FlxG.overlap(enemy, p1))  // Bala enemiga y player
			{
				p1.kill();	
				Global.lives--;				
				textoLives.destroy();
				LivesTextDraw();
				FlxG.sound.pause();
				FlxG.sound.play(AssetPaths.Player_Death__wav);
			}
			if (FlxG.overlap(p1.bala, enemy)) // Bala player y enemigo
			{
				enemyGroup.remove(enemy, true);
				p1.bala.kill();
				Global.score += 30;
				textoScore.destroy();
				ScoreTextDraw();
				FlxG.sound.play(AssetPaths.Enemy_Kill__wav);
			}
			
			if (FlxG.overlap(p1.bala,enemy.bullet)) //Bala player y bala enemiga
			{
				p1.bala.kill();
				enemy.bullet.kill();
				FlxG.sound.play(AssetPaths.Enemy_Kill__wav);
			}
			
			if (enemy.bullet.alive) //Struc y bala enemiga
			{
				for (struct in structGroup) 
				{
					if (FlxG.pixelPerfectOverlap(struct, enemy.bullet))
					{
						enemy.bullet.kill();
						structGroup.remove(struct, false);
						FlxG.sound.play(AssetPaths.Structure_Down__wav);
					}					
				}
			}	
			for (struct in structGroup) //struct y enemigos
			{
				if (FlxG.overlap(struct, enemy))
					{
						structGroup.remove(struct, true);
						FlxG.sound.play(AssetPaths.Structure_Down__wav);
					}
			}			
		}	
		
		if (p1.bala.alive) // Bala player y struct
			{
				for (struct	in structGroup) 
					{
							if (FlxG.overlap(struct, p1.bala))
							{
								structGroup.remove(struct, true);
								p1.bala.kill();
								FlxG.sound.play(AssetPaths.Structure_Down__wav);
							}
					}
			}
		if (FlxG.overlap(p1.bala, ovni)) //Bala player y ovni
		{
			p1.bala.kill();
			ovni.kill();
			Global.score += 300;
			textoScore.destroy();
			ScoreTextDraw();
			FlxG.sound.play(AssetPaths.Enemy_Kill__wav);
		}  
	}
	
	function OvniSpawn():Void // Spawn ovni aleatorio
	{
		if (ovniRandom.int(0 , 1000) == 50 && ovni.alive == false)
		{
			ovni.reset( -20, 10);
			FlxG.sound.play(AssetPaths.Enemy_Special__wav);
		}
		if (ovni.x > 180) 
			ovni.kill();
	}
	
	function PlayerLives():Void
	{
		if (p1.alive == false)
		{	
			if (deathTimer == 100)
			{
				Global.score = 0;
				FlxG.resetState();	
			}
			else
				deathTimer++;		
		}
		if (Global.lives == 0 || enemyGroup.countLiving() == -1)
		{
			FlxG.sound.pause();
			FlxG.switchState(new GameOver());
		}
		if (enemyGroup.countLiving() == -1)
		{
			Global.difficult += 1;
			FlxG.resetState();
		}
	}
	
	function ScoreTextDraw():Void 
	{
		textoScore = new FlxText(0, 0, 0, "Puntaje:" + Global.score, 8, true);
		textoScore.color = 0x000000;
		add(textoScore);
	}
	
	function HscoreTextDraw():Void 
	{
		textohScore = new FlxText(85, 0, 0, "HighScore:" + Global.hScore, 8);		
		textohScore.color = 0x000000;
		add(textohScore);
	}
	
	function LivesTextDraw():Void 
	{
		textoLives = new FlxText(0, 10, 0, "Vidas:" + Global.lives, 8);		
		textoLives.color = 0x000000;
		add(textoLives);
	}
}
