package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxStrip;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.text.FlxText;
import haxe.Timer;
import flixel.math.FlxRandom;



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
	private var timerShoot:Timer;
	private var enemyRandom:FlxRandom;
	private var ovniRandom:FlxRandom;
	private var enemyToDown:Bool;
	private var lives:Int;
	private var score:Int;
	private var hScore:Int;
	private var textoScore:FlxText;
	private var textohScore:FlxText;
	private var textoYouWin:FlxText;
	
	override public function create():Void
	{
		super.create();
		enemyGroup = new FlxTypedGroup<Enemy>();
		structGroup = new FlxTypedGroup<FlxSprite>();
		p1 = new Player(19, 14, AssetPaths.Personaje__png);
		ovni = new SpecialEnemy( -20, 5, AssetPaths.alienGrande__png);
		enemyToLeft = false;
		timerShoot = new Timer(1000);
		enemyRandom = new FlxRandom(0);
		ovniRandom = new FlxRandom(0);
		coordX = 13;
		coordY = 9;
		coordXs = 12;
		coordYs = 109;
		lives = 3;
		score = 0;
		hScore = 500;
		textoScore = new FlxText(0, 0, 0, "Puntaje:" + score, 8);
		textohScore = new FlxText(85, 0, 0, "HighScore:" + hScore, 8);
		textoYouWin = new FlxText(FlxG.width / 2, FlxG.height / 2, 0, "YOU WIN", 8);
		
		
		add(textohScore);
		add(textoScore);
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
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		timerShoot.run = EnemyShoot;
		
		OvniSpawn();
		EnemyMovement();
		Collides();
		EndGame();
		CheckHighScore();
	}
	

	function CheckHighScore()
	{
		if (score > hScore) 
		{
			hScore = score;
			textohScore.destroy();
			textohScore = new FlxText(85, 0, 0, "HighScore:" + hScore, 8);
			add(textohScore);
		}
	}
	
	function EnemyShoot() // Disparo aleatorio grupo de enemigos
	{
		if (enemyGroup.alive)
			enemyGroup.members[enemyRandom.int(0, enemyGroup.length - 1)].shoot();
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
			enemy.x += 0.3;
		}
		else 
		{
			for (enemy in enemyGroup)
			enemy.x -= 0.3;
		}
		
	}
	
	function Collides():Void // Colisiones
	{	
		for (enemy in enemyGroup)
		{
			
			if (FlxG.overlap(enemy.bullet, p1) || FlxG.overlap(enemy, p1)) 
			{
				p1.kill();
				lives = 0;
			}
			if (FlxG.overlap(p1.bala, enemy))
			{
				enemyGroup.remove(enemy, true);
				p1.bala.kill();
				score += 30;
				textoScore.destroy();
				textoScore = new FlxText(0, 0, 0, "Puntaje:" + score, 8);
				add(textoScore);
			}
			
			if (FlxG.overlap(p1.bala,enemy.bullet)) 
			{
				p1.bala.kill();
				enemy.bullet.kill();
			}
			
			if (p1.bala.alive && p1.bala.y >= 109 && p1.bala.y <= 117)//EXPERIMENTAL
			{
				for (struct	in structGroup) 
					{
							if (FlxG.overlap(struct, p1.bala))
							{
								structGroup.remove(struct, true);
								p1.bala.kill();
							}
					}
			}
			if (enemy.bullet.y > 108 && enemy.bullet.y < 123 && enemy.bullet.alive)//EXPERIMENTAL
			{
				for (struct in structGroup) 
				{
					if (FlxG.pixelPerfectOverlap(struct, enemy.bullet))
					{
						structGroup.remove(struct, false);
						enemy.bullet.kill();
					}
					if (FlxG.overlap(struct, enemy))
					{
						structGroup.remove(struct, true);
					}
				}
			}
		}	
		if (FlxG.overlap(p1.bala, ovni))
		{
			p1.bala.kill();
			ovni.kill();
			score += 300;
			textoScore.destroy();
			textoScore = new FlxText(0, 0, 0, "Puntaje:" + score, 8);
			add(textoScore);
		}  
	}
	
	function OvniSpawn():Void // Spawn ovni aleatorio
	{
		if (ovniRandom.int(0 , 1000) == 50 && ovni.alive == false)
		{
			ovni.reset( -20, 10);
		}
		if (ovni.x > 180) 
			ovni.kill();
	}
	
	function EndGame():Void 
	{
		if (lives == 0)
			FlxG.switchState(new GameOver());
	}
}
