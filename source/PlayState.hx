package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import haxe.Timer;
import flixel.math.FlxRandom;



class PlayState extends FlxState
{
	public var coordX:Float;
	public var coordY:Float;
	public var coordXs:Float;
	public var coordYs:Float;
	public var enemyGroup:FlxTypedGroup<Enemy>;
	public var structGroup:FlxTypedGroup<Enemy>;
	private var p1:Player;
	private var ovni:SpecialEnemy;
	private var enemy1:Enemy;
	private var struct:Enemy;
	private var specialEnemy:SpecialEnemy;
	private var enemyToLeft:Bool;
	private var timerShoot:Timer;
	private var enemyRandom:FlxRandom;
	private var ovniRandom:FlxRandom;
	var enemyToDown:Bool;
	
	
	override public function create():Void
	{
		super.create();
		enemyGroup = new FlxTypedGroup<Enemy>();
		structGroup = new FlxTypedGroup<Enemy>();
		enemyToLeft = false;
		timerShoot = new Timer(1000);
		enemyRandom = new FlxRandom(0);
		ovniRandom = new FlxRandom(0);
		coordX = 13;
		coordY = 9;
		coordXs = 12;
		coordYs = 109;
		p1 = new Player(19, 14, AssetPaths.Personaje__png);
		ovni = new SpecialEnemy( -20, 5, AssetPaths.alienGrande__png);
		add(ovni);
		ovni.kill();
		add(p1);
		FlxG.camera.bgColor = 0xFF1E00FF;
		
		for (i in 0...3) // Instanciacion estructuras
		{
			struct = new Enemy(coordXs, coordYs, AssetPaths.CuartoDeMuro__png);
			structGroup.add(struct);
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
		EnemyMovement();
		timerShoot.run = EnemyShoot;
		Collides();
		
		
		if (ovniRandom.int(0 , 1000) == 50 && ovni.alive == false)
		{
			ovni.reset( -20, 10);
		}
		if (ovni.x > 180) 
			ovni.kill();
	}
	

	
	function EnemyShoot() // Disparo aleatorio grupo de enemigos
	{
		enemyGroup.members[enemyRandom.int(0, enemyGroup.length - 1)].shoot();		
	}
	
	
	function EnemyMovement():Void // Movimiento del grupo de enemigos
	{
		for (i in enemyGroup)
		{
			if (i.x > FlxG.width - i.width)
			{
				enemyToLeft = true;      	
				enemyToDown = true;
			}
			if (i.x < 0)
			{
				enemyToLeft = false;
				enemyToDown = true;
			}
		}
		if (enemyToDown == true)
		{
			for (i in enemyGroup)
			i.y += 10;
		}
		enemyToDown = false;
		if (enemyToLeft == false)	
		{
			for (i in enemyGroup)
			i.x += 0.3;
		}
		else 
		{
			for (i in enemyGroup)
			i.x -= 0.3;
		}
		
	}
	
	function Collides():Void // Colisiones
	{
		for (i in structGroup) 
		{
			if (FlxG.overlap(p1.bala,struct))
			{
				struct.kill();
				p1.bala.kill();
			}
			
			if (FlxG.overlap(i,enemy1.bullet)) 
			{
				enemy1.bullet.kill();
				struct.kill();
			}
		}
		
		for (i in enemyGroup)
		{
			
			if (FlxG.overlap(i.bullet, p1) || FlxG.overlap(i, p1)) 
				
				p1.kill();
			
			if (FlxG.overlap(p1.bala, i))
			{
				enemyGroup.remove(i, true);
				p1.bala.kill();
			}
			
			if (FlxG.overlap(p1.bala,i.bullet)) 
			{
				p1.bala.kill();
				i.bullet.kill();
			}
		}
	}
}