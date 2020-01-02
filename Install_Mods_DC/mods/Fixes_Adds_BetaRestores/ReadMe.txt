Please load this mod AFTER Dreamcast Conversion, but BEFORE any Autodemo Conversion mods!


This mod will also:
-Fix the graphics for the Nights Pinball table cards with its included PVM files. Normally, an unused set of card graphics doesn't appear due to conflicting global texture IDs, but these PVMs fix that. There is a version for those that use Dreamcast Conversion, and those that don't.
-Translates the unused text for the unused chao card item in Station Square for all languages.





Animation/Action Viewer controls:

After activating by pressing B, Y, and X at the same time...

Your rings will tell you what your current animation Index ID is.
Your lives will tell you what your current action ID is.

The minutes in the timer will tell what NJS_ACTION the current animation index is using, the seconds in the timer will tell what the current animation index has its nextanim set to, and the frames in the timer will display the property of the current animation index. ....If you're playing as Gamma, the seconds in the timer will be incorrect when the nextanim is below 30. This is to make sure he doesn't get screwed over by a 'time over' when using this feature. When playing as Big, the timer does not appear at all, so none of the timer information will be displayed.

Press L and R to decrease and increase the current animation index ID on your character.
Don't worry, it shouldn't allow you to go below 0, and I put in range caps for each character's last animation ID, so you can't go too high.

By holding down the Y button and pressing L and R, you can decrease and incease the current action ID. WARNING! This is very prone to crashing. Only use if you know what you're doing!

To turn off the animation viewer, press B, Y, and X at the same time again, or simply exit or restart the level.

Note: This will not function in the Test Levels/Hedgehog Hammer





TGS Mode explanation:

Pressing L and R at the same time on the title screen, file select screen, options screen, etc. will take you straight to the TGS Mode title screen. 
This mode has had many fixes applied to it, such as making the title screen not flipped horizontally anymore! It functions much like the already existing TGS Menus mod by MainMemory, but with a few new features. 
First off, the English TGS rule graphics from the Autodemo have been implemented, and will check the language of the current file to determine which graphics to display. By default, it will use the English graphics. 
Timings have been adjusted to accomodate for 60fps on the PC version, and the graphics will stretch to fit (hopefully) any screen resolution!
Holding Y + X on the title screen will bring up the level select, allowing you to pick a character and a stage. Oddly, not all stages/bosses are on this prototype level select, but whatever. Pressing L and R will switch menus. (Thanks MainMemory!)
Holding L + Y + X on the title screen will take you to the blue level select screen, which lacks Hedgehog Hammer Acts 2 and 3, but includes more levels, like more bosses.
Finally, a secret button combo has been added to the TGS title screen: hold Y + B to trigger a part of the TGS Mode coding that is normally unused even within the mode itself. It will take you straight to the Station Square Chao Garden. ...Not...too useful, but hey, it's there now.



Mystic Ruins Jungle Sound Effect explanation:

So, there's an object used in the Mystic Ruins that plays various sound effects depending on what it's set to play, and where you are. In the jungle, one of its uses is to play sounds that sound like animals and birds and whatnot around you, however, there is coding within this object that checks for the time of day, and if it's night, it's meant to switch out that noise with a normally unused sound of crickets and such. But the coding for it never runs due to how it's programmed. This configurable option fixes that so that whenever you enter the jungle at night, you'll be treated to new sounds, which also makes more sense than implying that birds and all wild animals in there never sleep. As a note, this will also disable a check for the Final Egg Mystic Ruins base, where a certain sound effect was prevented from being played. This has already been fixed in PkR's Sound Overhaul mod, but it does not include the sound effect swap that this mod has. Running both mods at the same time should not cause any issues, so don't worry.


Hot Shelter and Lost World Background Noises explanation:

So, every level has sound banks that load when the level loads that contains sounds and such. One of them, however has sounds that are usually meant to play as looping noise in the level. For example, the wind you hear in Windy Valley is from one of that level's sound banks. The background sound bank. However, for whatever reason, it seems that Hot Shelter and Lost World never bother to use their banks for this, and thus all sounds within those banks go unused. You can enable my take on the noises, my guesses as to how they were going to be used, and a list of the sounds that are enabled by it are here (Some of these aren't from the looping sound bank, but are instead from the level's other unique sound bank):

Hot Shelter Act 1: A very, very quiet background hum that is practically impossible to hear in noraml gameplay, and still difficult to hear even with the music disabled.
Hot Shelter Act 1: Only in the hallways around the fish tanks will this sound play. You'll hear some "bloop"s, like big bubbles in water. The sound effect plays randomly in no set pattern.

Hot Shelter Act 2 (Amy version): When you enter the gear area, you'll hear the clanking of the gears.
Hot Shelter Act 2 (Amy version): When you enter the area after the turntable bridge room, you'll hear some low machinery noises. It's easiest to hear when Amy grabs the balloon at the end of the level.

Hot Shelter Act 2(3) (Gamma version): His level also has the gear noise in the same area.
Hot Shelter Act 2(3) (Gamma version): His level also has the machinery noise after the turntable bridge room.
Hot Shelter Act 2(3) (Gamma version): His version also has a unique sound, played only during the cargo section.


Lost World Act 1: A very quiet and low wind sound effect. It's extremely difficult to hear in normal gameplay.
Lost World Act 1: Only while you're in the snake room, you'll hear an unused sound effect that sounds like something big moving through the water. It's a sound effect for what I believe to have been intended for the snake!

Lost World Act 2: Only at the start of the Act for Sonic, on the cliff, you can hear a wind sound if you listen carefully. It goes away once you enter the dark room.




Explanation on Animations:

So, there's three options you can toggle to change various things relating to animations in the game.

Landing animations: Each character has two animations that they're meant to use when they land on the ground from a high enough height: one for holding an object, and one for not holding an object. Of all the characters, only Gamma uses his neutral landing animation normally. Each character is actually coded to use these animations, but they're overwritten on the same frame by a function that changes their animation to...not the landing animation. Enabling the landing animation option disables this function every time you land long enough to allow the landing animations to display. I also decreased the height that each character has to fall in order to trigger them, as most were completely insane and something you'd almost never see in normal gameplay. (The sheer drop at the end of Beta Windy Valley Act 1 was just barely enough to activate it for Sonic!) Also, and this is important, in order to see these animations in-game, you must land on a completely flat surface with a fast enough falling speed with no horizontal momentum. If the ground is even slightly tilted, or you are moving horizontally even slightly, the animation will not trigger.


Animation Fixes and Adds: So, there's some problems with some of the animations in the game, and this option will attempt to fix most of them. For example, when Knuckles or Amy take damage, their damage animation loops over and over until they hit the ground. This will be fixed with this option. This option also adds some normally unused animations for some characters. Tails, for example, will finally be able to use proper animations for jumping and falling while holding something. He had animations for this in the game, but they were completely unused by any of his animation index slots. Speaking of holding things, this option will also allow characters who are standing idle and holding something to actually animate instead of staying completely still. This is how it was in the original Japanese release of the game, but for some reason was disabled for Sonic, Tails, Knuckles, and Amy in all future versions of the game. 

TLDR, here is a list of all the changes this option will make:

-Tails gains animations for jumping while holding something, falling while holding something, and landing while holding something.
-Additional programming is added to make Tails use the proper animation index when jumping while holding something.
-Sonic, Tails, Knuckles, and Amy will now animate while standing still and holding something, like in the original Japanese release.
-Amy's intended landing animation index slot will now actually use the landing animation.
-Knuckles' and Amy's damage animations will no longer loop over and over.
-Amy now has a unique animation for getting blown about by a gust of wind, which is normally a completely unsued animation!


Knuckes animations:
There's a third option to give Knuckles more animations in-game, mostly consisting of entirely unused animations. In boss fights, his neutral standing animations will be replaced with his character select screen animation. However, if you jump up as Knuckles during a boss, and press B or X, he'll stop immediately and fall straight down. If the floor below him is perfectly flat, he'll land into a different animation than his neutral stance. ...This is nothing new. He does in the game normally, however, alongside his character selection animation is a transition animation that is never seen or used. That animation is used during boss fights in this sceneraio when this option is enabled. Also, he is given new, normally unused idle animations. Three, in fact, with two being transitions. In order to see these in the boss, I highly suggest using the Idle Chatter mod.