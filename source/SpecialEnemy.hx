package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class SpecialEnemy extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
	}
	public function OvniMovement()
	{
		x += 1;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		OvniMovement();
	}
}