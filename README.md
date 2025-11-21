# AutoRotation

An [AutoHotKey](https://www.autohotkey.com) script for World of Warcraft that automates your combat rotations.  Most of the magic here is how to setup your game so it works.

**This technique allows fully automated skill rotations w/out the use of botting.**

## How It Works

The AHK script is going to press buttons F1 thru F12 multiple times a second.  It's going to press them in that order, over and over and over again, indefinitely.

You can bind spells to those F keys.  Normally, pressing keys randomly would cause all sorts of error messages and failure sounds, it would be a mess.

The trick is to change your game to make these keypresses unnoticable to you, so there are no error messages, no spell fizzle sounds, no auto-targeting of mobs, nothing unusual.

Moreover, there is a trick -- at least in WOTLK, which is what I play -- that allows you to build macros that pick the priorty skill every time it's available.

The end result is fully automated rotation casts from your character.

## Setting It Up

- Install [AutoHotKey](http://autohotkey.com/)
- Download this [zipfile](https://github.com/whipowill/ahk-autorotation/archive/master.zip)
- Merge the ``Data`` files into your game folder
	- This will silence all fizzle spell sounds
- Merge the ``Interface`` files into your game folder
	- This installs the MacroMagic addon which allows easy silence of errors in macros using ``/x``
- Run the AHK script by right-clicking and selecting "Run As Administrator"
	- Note the script will print pixels in the top left corner to indicate status
	- By default the script is running but automation is not turned on (red)
	- Press ``PageUp`` to turn automatic rotation on or off (green)
	- Press ``PageDown`` to reset the script (clear everything, back to red)
	- Press ``Home`` for a secondary fishing mode (blue)
	- Press ``End`` while moused over your fishing bobber to set the color
- Open World of Warcraft and enter a game
- Disable error speech in sound settings
- Modify your spells and keybinds
	- You're going to use action bar slots 1-6 for your left hand
	- You're going to use action bar slots 7-12 for automatic clicks
	- Set F1-F12 as secondary binds for these automatic action bar slots
- Target a mob, see what happens

## Taking It To The Next Level

This is secret to the madness.  Now that you have AHK setup and working, you can craft advanced macros to put in your auto-click slots on your action bar.  For most characters, you will have 4 or 5 macros:

- ``AutoTarget`` - will auto-target next enemy when your current target dies
- ``AutoAttack`` - for keeping yourself always attacking the enemy
- ``Untimed`` - for casting your untimed, spammable skills
- ``Timed`` - for casting your timed, cooldown skills

An example ``AutoTarget`` macro:
```
/stopmacro [mounted] [nocombat] [stealth]
/targetenemy [noexists] [dead]
/assist [@focus]
```

An example ``AutoAttack`` macro:
```
/stopmacro [notarget] [noharm] [harm, dead] [stealth]
/run UIErrorsFrame:Hide()
/startattack
```

An example ``Untimed`` macro:
```
#showtooltip
/stopmacro [noharm] [harm, dead] [stealth]
/x
/castsequence reset=target Spell A, Spell B, Spell C, Spell D
/x
```

An example simple ``Timed`` macro (spells w/ no global cooldown):
```
#showtooltip
/stopmacro [noharm] [harm, dead]
/x
/cast Spell A
/cast Spell B
/cast Spell C
/cast Spell D
/x
```

An example advanced ``Timed`` macro (spells w/ global cooldown):
```
#showtooltip
/stopmacro [noharm] [harm, dead]
/x
/castsequence reset=0 0,0,0,Spell A
/castsequence reset=0 0,0,Spell B
/castsequence reset=0 0,Spell C
/castsequence reset=0 Spell D
/x
```

This ``castsequence`` is only required when using spells that trigger a global cooldown, bc that cooldown will prevent subsequent spells from being cast.  I learned about this technique on a private server forum [post](https://forum.warmane.com/showthread.php?t=382668&page=4).

## Issues To Know

- Some spells, when clicked, will automatically target the nearest enemy and cast that spell on them.  It's weird in the game what spells will do this and what spells won't.  Whenever this happens, you have to wrap that spell in a macro with ``/stopmacro [noharm] [harm, dead]`` at the top.

- Some spells don't have a cooldown, but you don't want to cast them every second.  An example might be a Hunter DoT or a Warrior bleed.  You either have to add the spell to a macro with a ``castsequence``, or you just need to apply it manually w/ buttons 1-6 and leave it out of automatic rotation.

## Fishing Mode

If you press ``Home`` you can switch the auto click into fishing mode.

You need to be zoomed in on the water all the way with your fishing rod equipped and your fishing skill in the ``1`` slot on your action bar.  Hover over the darkest blue part of the bobber feathers and press the ``End``, which will mark that color and scan for motion.

It doesn't work perfectly, but it works pretty well.  This mode will turn off after 15 minutes.

## External Links

- [WowGaming Guide On Making A Macro](https://wowgaming.github.io/wiki-en/wotlk-making-a-macro.html) - WOTLK rules
- [AutoHotKey List Of Keys](https://www.autohotkey.com/docs/KeyList.htm)
- [Will Scarlet's NoShift Druid Addon](https://github.com/whipowill/wow-addon-noshift) - awesome combo w/ this

## Credits

- Sound pack by [ErrorSoundsBeGone](https://www.curseforge.com/wow/addons/project-8021)
- Error supression by [MacroMagic](https://www.wowace.com/projects/macromagic)