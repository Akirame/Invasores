package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{
	
	private var p1:Player;
	private var enemy1:Enemy;
	private var enemy2:Enemy;
	private var enemy3:Enemy;
	
	
	override public function create():Void
	{
		super.create();
		p1 = new Player(19, 14, AssetPaths.Personaje__png);		
		add(p1);
		FlxG.camera.bgColor = 0xFF1E00FF;
		enemy1 = new Enemy(100, 100, AssetPaths.marcianito__png);
		enemy2 = new Enemy(75, 100, AssetPaths.Marcianito2__png);
		enemy3 = new Enemy(50, 100, AssetPaths.Marcianito3__png);
		//add(enemy1);
		//add(enemy2);
		//add(enemy3);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	
	}
}