package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class Player extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		x = (FlxG.width / 2- width/2);
		y = (FlxG.height - height);
	}	
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		movement();
	}
	
	public function movement()
	{
		velocity.x = 0;
		if(FlxG.keys.pressed.J)
			velocity.x -= ( 80 * FlxG.elapsed * FlxG.updateFramerate);		
		
		if(FlxG.keys.pressed.K)
			velocity.x += ( 80 * FlxG.elapsed * FlxG.updateFramerate);	
	}
	
}