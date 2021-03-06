package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flash.system.System;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, watch out!\n
			This Mod contains some SHUTTLE MAN!\n
			HE IS VERY AWESOME!!!\n
			Press ESCAPE to disable SHUTTLE MAN!\n
			Press ENTER to ignore this message.\n
			You've been warned!",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
		{
			if(!leftState) {
				var ACCEPT:Bool = controls.ACCEPT;
				if (controls.BACK || ACCEPT) {
					leftState = true;
					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					if(!ACCEPT) {
						ClientPrefs.ShuttleMan = false;
						ClientPrefs.saveSettings();
						FlxG.sound.play(Paths.sound('cuh'));
						FlxTween.tween(warnText, {alpha: 0}, 1, {
							onComplete: function (twn:FlxTween) {
								MusicBeatState.switchState(new TitleState());
							}
						});
					} else {
						FlxG.sound.play(Paths.sound('cuh'));
						FlxTween.tween(warnText, {alpha: 0}, 1, {
							onComplete: function (twn:FlxTween) {
								MusicBeatState.switchState(new TitleState());
							}
						});
					}
				}
			}
			super.update(elapsed);
		}
	}
	