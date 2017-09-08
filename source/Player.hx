package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.system.FlxAssets.FlxGraphicAsset;


/**
 * ...
 * @author G
 */
class Player extends FlxSprite 
{	
	var bala:Bullet_Player;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		x = (FlxG.width / 2- width/2);
		y = (FlxG.height - height);	
		bala = new Bullet_Player(0, 0, AssetPaths.BalaPersonaje__png);
		FlxG.state.add(bala);
		bala.kill();
	}	
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);	
		movement();
		OOB();
		shoot();
	}
	
	private function movement()
	{
		velocity.x = 0;
		if(FlxG.keys.pressed.LEFT)
			velocity.x -= ( 80 * FlxG.elapsed * FlxG.updateFramerate);		
		
		if(FlxG.keys.pressed.RIGHT)
			velocity.x += ( 80 * FlxG.elapsed * FlxG.updateFramerate);
	}
	
	private function OOB()
	{
		if (x > FlxG.width - width)
			x = FlxG.width - width;
		if (x < 0)
			x = 0;		
	}
	
	private function shoot()
	{
		if (FlxG.keys.justPressed.Z && bala.alive == false)
		{
			bala.reset(x+ width/2-1.5, y);
		}
	}
}