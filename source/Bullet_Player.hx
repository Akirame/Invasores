package;

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
		
		velocity.y = -500 // velocidad de la bala
	}
	
	override public function update()
	{
		//Aca va la colision con enemigos wachin <3
	}
	
}