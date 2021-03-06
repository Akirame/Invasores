package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
/**
 * ...
 * @author ...
 */
class Menu extends FlxState 
{
	var texto:FlxText;
	
	override public function create():Void
	{
		texto = new FlxText (40, 20, 0, "Invaders", 16);
		texto.color = 0x72ff00;
		add (texto);
		texto = new FlxText (0, 50, 0, "Hecho por:", 8);		
		texto.color = 0x72ff00;
		add(texto);
		texto = new FlxText (0, 60, 0, "José Quintana Martín", 8);
		texto.color = 0x72ff00;
		add(texto);
		texto = new FlxText (0, 70, 0, "Leandro Rodriguez", 8);
		texto.color = 0x72ff00;
		add(texto);
		texto = new FlxText (0, 80, 0, "Gastón Villalba", 8);
		texto.color = 0x72ff00;
		add(texto);
		texto = new FlxText (40, 100, 0, "Z para comenzar", 8);
		texto.color = 0x72ff00;
		add(texto);
		
		FlxG.sound.play(AssetPaths.pantalla_de_inicio__wav);
	}
	
	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.Z)
			FlxG.switchState(new PlayState());
	}
	
}