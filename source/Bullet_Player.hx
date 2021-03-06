package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Bullet_Player extends Bullet 
{	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);			
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		velocity.y = -200;
		if ( y < 0)
		kill();
	}		
}