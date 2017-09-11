package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Enemy extends FlxSprite 
{

	var bullet:Bullet_Enemy;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		bullet = new Bullet_Enemy(0, 0, AssetPaths.BalaEnemiga__png);
		FlxG.state.add(bullet);
		bullet.kill();		
	}
	
	public function shoot()
	{		
		if(bullet.alive == false)
			bullet.reset(x+width/2-1, y+2);
	}
	
}