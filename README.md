# Rotation

In WoW it's all about button mashing.  The faster, the better your DPS is going to be.  I wanted to be able to bring to WoW what I had made for Diablo II, an automated clicker to release me mentally from the repitition of combat.

This isn't a bot, so it won't be as efficient, but it's pretty darn close.  And I don't think it will get you banned, bc it's not doing anything other than mashing your keys.  Most of the magic here is how to setup your game so button mashing works.

## How It Works

The AHK script is going to press buttons 7 thru 12 multiple times a second.  It's going to press them in that order -- 7, 8, 9, 10, 11, 12 -- over and over and over indefinitly.

The trick is to change your game to make this process unnoticable to the player, so there are no error messages, no spell fizzle sounds, no auto-targeting of mobs, nothing unusual.

It's just that when you do target a mob, and you are within attack range, you are going to unleash hell on them in a fully automated way.

## Setting It Up

This is a multi-step process:

- Install [AutoHotKey](http://autohotkey.com/)
- Download this repository
- Install the sound files
	- Will silence all fizzle spell sounds
- Disable error speech in sound settings
- Modify your keybinds
	- Set F1-12 as secondary binds for 1-12
- Add the ``AutoAttack`` macro

```
/run UIErrorsFrame:Hide()
/stopmacro [noharm] [harm, dead]
/startattack
```

- Place your spells in the right order

This is where the magic happens.  You want to place your spells on keys 7-12 on the action bar, with 7 being the highest priority and 12 being the lowest priority.  The AutoAttack macro you made has to be one of them, and probably belongs in spot 12.  Keys 1-6 are not touched.

- Run the AHK script
- Press mouse button 2 (on the side) to activate the script
- Target a mob, see what happens

## Issues

- Some spells, when clicked, will automatically target the nearest enemy and cast that spell on them.  It's weird in the game what spells will do this and what spells won't.  Whenever this happens, you have to wrap that spell in a macro with ``/stopmacro [noharm] [harm, dead]`` at the top.

- Some spells don't have a cooldown, but you don't want to cast them every second.  An example might be a Hunter DoT or a Warrior bleed.  You either have to add the spell to a macro with a castsequence, or you just need to apply it manually w/ buttons 1-6 and leave it out of automatic rotation.