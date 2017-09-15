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
	//private var enemy2:Enemy;
	//private var enemy3:Enemy;
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
		
		for (i in 0...3) 
		{
			struct = new Enemy(coordXs, coordYs, AssetPaths.CuartoDeMuro__png);
			structGroup.add(struct);
			coordXs += 12;
		}
		
		for (i in 0 ... 8) 
		{
			enemy1 = new Enemy(coordX, coordY, AssetPaths.marcianito__png);
			enemyGroup.add(enemy1);
			coordX += 14;			
		}
		coordX = 13;
		coordY += 11;
		for (i in 0 ... 8) 
		{
			enemy1 = new Enemy(coordX, coordY, AssetPaths.Marcianito2__png);
			enemyGroup.add(enemy1);
			coordX += 14;			
		}
		coordX = 13;
		coordY += 11;		
		for (i in 0 ... 8) 
		{
			enemy1 = new Enemy(coordX, coordY, AssetPaths.Marcianito3__png);
			enemyGroup.add(enemy1);
			coordX += 14;			
		}
		
		add(enemyGroup);
		add(structGroup);
		/*coordY += 11;
		coordX = 13;
		for (i in 0 ... 10) 
		{
			enemy1 = new Enemy(coordX, coordY, AssetPaths.marcianito__png);
			add(enemy1);
			coordX += 14;			
		}
		coordX = 13;
		coordY += 11;
		for (i in 0 ... 10) 
		{
			enemy2 = new Enemy(coordX, coordY, AssetPaths.Marcianito2__png);
			add(enemy2);
			coordX += 14;			
		}
		coordX = 13;
		coordY += 11;		
		for (i in 0 ... 10) 
		{
			enemy3 = new Enemy(coordX, coordY, AssetPaths.Marcianito3__png);
			add(enemy3);
			coordX += 14;			
		}*/
	
	}

	override public function update(elapsed:Float):Void
	{
		
		super.update(elapsed);		
		EnemyMovement();
		timerShoot.run = EnemyShoot;
		
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
			
			if (FlxG.overlap(i.bullet, p1) || FlxG.overlap(i,p1)) 
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
		
		
		if (ovniRandom.int(0 , 1000) == 50 && ovni.alive == false)
		{
			ovni.reset( -20, 10);
			OvniMovement();
		}
		if (ovni.x > 180) 
			ovni.kill();
	}
	
	function OvniMovement()
	{
		ovni.velocity.x += ( 110 * FlxG.elapsed * FlxG.updateFramerate);
	}
	
	function EnemyShoot() 
	{
		enemyGroup.members[enemyRandom.int(0, enemyGroup.length - 1)].shoot();		
	}
	
	
	function EnemyMovement():Void 
	{
		for (i in 0...enemyGroup.length)
		{
			if (enemyGroup.members[i].x > FlxG.width - enemyGroup.members[i].width)
			{
				enemyToLeft = true;      	
				enemyToDown = true;
			}
			if (enemyGroup.members[i].x < 0)
			{
				enemyToLeft = false;
				enemyToDown = true;
			}
		}
		if (enemyToDown == true)
		{
			for (i in 0...enemyGroup.length)
			enemyGroup.members[i].y += 10;
		}
		enemyToDown = false;
		if (enemyToLeft == false)	
		{
			for (i in 0...enemyGroup.length)
			enemyGroup.members[i].x += 0.3;
		}
		else 
		{
			for (i in 0...enemyGroup.length)
			enemyGroup.members[i].x -= 0.3;
		}
		
	}
}