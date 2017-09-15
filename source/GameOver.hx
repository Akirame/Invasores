package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxStrip;
import flixel.FlxSprite;
import flixel.text.FlxText;

/**
 * ...
 * @author G
 */
class GameOver extends FlxState 
{
	var cartelito:FlxText;

	override public function create():Void 
	{
		super.create();
		cartelito = new FlxText(44, 68, 0, "perdiste perro", 8);
		add(cartelito);
	}
	
}