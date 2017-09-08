package;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Bullet_Enemy extends Bullet 
{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		velocity.y = 250 // velocidad de la bala (es la mitad del jugador)
	}
	
	override public function update()
	{
		//Aca va la colision con la estructura y el jugador wachin <3
	}
}