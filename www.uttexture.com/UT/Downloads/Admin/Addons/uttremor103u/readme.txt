Get the latest version at:
http://www.planetquake.com/oz/tremor

Quick Start:
1. Install the Tremor umod by double clicking on it.
2. Start a new UT game with the Tremor mutator applied.
3. Play.

To run a server you must edit your UnrealTournament.ini file
that is located in the System directory of UT.

Search for where the other "ServerPackages" lines are and
add the following lines:

ServerPackages=Tremor
ServerPackages=TremorMultiMesh

And if you want to run a Tremor Rocket Arena server also add:

ServerPackages=TremorRocketArena

---------------------------------------------------------------------

This mod brings a new level of gameplay to Unreal Tournament.
The style of play is very different from normal UT; Quake
players should feel right at home.

What got fixed:
1. New, simplified weapons.

2. Player movement feels more natural and less mechanical.

3. Snap shots actually work now.  This one fix alone goes a long
   ways toward making UT playable at a professional level.  See
   the tech page (http://www.planetquake.com/oz/tremor/tech.html)
   for all the gory information about this fix.

4. Many (and there were a lot) of the "random" features were removed.
   Those features may make the game more realistic but as you
   introduce randomness you remove the emphasis on skill.  This
   is another big fix towards making UT playable at the professional
   level.  Again, see the tech page for detailed information.

5. Rocket/Grenade jumping actually works.  It did before, but not
   very well at all.

6. Faster gameplay: Player speeds are faster, rockets are faster,
   rockets bounce targets around more... etc.

7. Damage feedback sounds.

8. Player sizes increased a bit.


Known issues:
1. The weapon/health/powerup/etc models are not done.
2. The weapons/health/etc skins are not done.
3. There are no visible countdown timers for the powerups yet.
4. Armor over 150 does not show up in the HUD.
5. You must be using at least the 413 patch to UT.
6. No server browser stuff or anything yet.  Don't know if this
   is possible for a mutator.
7. Many of the normal UT mutators won't work because they modify
   UT specific stuff that doesn't apply to Tremor.  I hope
   to recreate some of the most useful mutators for Tremor.

Strafe jumping works (not exactly like Quake but it's there).

As of right now, weapon switching is instant.  I like it that
way but in order to provide maximum flexability there will
be a way of adjusting this in the future.

An air-control value of 25% seems to feel the best for me.  Make 
sure you're not playing in "Hardcore" mode unless that's
what you ment to do.  (it increases damage for one thing)

Some maps require you to use the impact hammer to get to the weapons,
this is a problem as there is no impact hammer in Tremor... This is
especially bad if the rocket launcher is the weapon you're trying to
get to).  Grenade jump? Maybe a team effort using railgun jumping?
:)

Some maps may have tight door openings (AS-Frigate) but so far the
players have fit through every opening I've tried on the base maps.

Some maps may have too small spawn points (DM-Fractal).  If you
spawn at an invalid point the game will stop.  The game actually
checks the bots to make sure they can spawn at the desired point.
It doesn't check for players though.  I have a fix for this but
it doesn't work with the mutator so I haven't included it in this
version.  The real solution is to patch the main game code because
it should check the spawn point anyway.  This may not be an issue
at all across the network.

I've found that if you experience delays in the sounds (especially
the "honk" damage sound) you may need to turn off direct sound.  
(type "preferences" from the console and go to the audio section)


