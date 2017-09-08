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
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	
	}
}