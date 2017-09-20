package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxStrip;
import flixel.FlxSprite;
import flixel.text.FlxText;
import source.Global;

/**
 * ...
 * @author G
 */
class GameOver extends FlxState 
{
	var cartelito1:FlxText;
	var cartelito2:FlxText;
	var cartelito3:FlxText;
	var conta1:Int;
	var conta2:Int;
	var Apagado:Bool;

	override public function create():Void 
	{
		super.create();
		cartelito1 = new FlxText(5, 30, 0, "Score: " + Global.score, 16);
		cartelito2 = new FlxText(5, 50, 0, "HighScore: " + (Global.hScore) , 16);
		cartelito3 = new FlxText(22, 90, 0, "GAME OVER", 16);
		add(cartelito1);
		add(cartelito2);
		add(cartelito3);
		cartelito2.kill();
		cartelito3.kill();
		conta1 = 0;
		conta2 = 0;
		Apagado = false;
		FlxG.sound.play(AssetPaths.game_over__wav);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);		
 		if (conta1 == 60 && cartelito2.alive == false)		
			cartelito2.revive();		 		 	
		if (conta2 == 40)
		{
			if (Apagado == false)
			{
				cartelito3.revive();				
				Apagado = true;
				conta2 = 0;
			}
			else
			{
				cartelito3.kill();
				Apagado = false;
				conta2 = 0;
			}
		}	
		conta1++;
		conta2++;
	}	
}