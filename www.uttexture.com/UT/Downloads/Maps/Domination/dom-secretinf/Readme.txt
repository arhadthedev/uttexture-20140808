========================================
InfAdds-Package (25rd of march 2000)
featuring the M2.50 machine gun (turret)
========================================

Installation Instructions and Release Notes:
==========================
Infiltration is NOT needed to use this turret.
Simply copy the InfAdds.u file into your UT\System folder.
Add the example map (DM-INFShootingRange.unr) to your UT\Maps folder.
Add the texture file (Warren1.utx) to your UT\Textures folder.

How to use:
===========
Load the package from the classes browser inside UnrealEd.
You will find the new Turret under:

Decorations.UT_Decoration.Inf_Decoration.INFIL_UTTurret.INFIL_UTM2_50

Simply select it and place it where ever you want.

You will probably want to create a simple turret base for your M2 to rest on, 
so it doesn't appear to float.

To get control over the turret you have to add a standard Trigger also.
Setup the Trigger's Event to the Turret's Tag to combine them.
If you have more than one turret, make sure each of your M2 and Trigger tags are
different.

For more realism, attach the Trigger to the Turret by entering the Turrets Tag
inside the AttachTag of the Trigger (found under Movement), and place it on the
back part of the turret itself... result: the player has to move with the rotation
of the M2 to get control over it.
Try to setup the turret's location (under movement) using even values:
this means don't use: Location=(X=128.222450,Y=63.489000,Z=21.002361)
change it into: Location=(X=128.000000,Y=64.000000,Z=20.000000) 
This will result in a smooth rotation. Else, the pivot point will rotate around
the next nearest possible location using even values that will cause shifting.
(That issue is UT engine related)

For advanced mappers:
=====================
The setup properties don't have to be changed normally. The setups that will be useful
are the Min/MaxPitch/Yaw parameters. These can be used to force the turret to stay within
a specific radius. ie. you can use this for a turret mounted inside a small opening or
something similiar, and let it just rotate between the edges, or it will collide
with the walls.

All other properties really don't need to be changed. If you like to get more info about
the other properties, simply doubleclick on the classes name to open the script of the
main turret class INFIL_UTTurret.

All properties that can be setup inside UnrealEd will be listed in the upper part of the
script and they are commented to let you kow what it should be used for.

Bot support:
============
Bots can use the turret as well, but their 'normal' goals are a higher priority at
the moment. They will use the turret, if enemies are just inside the radius, nothing more.
If a bot controls a turret, a player can get access to it by simply walking inside the
triggers radius. Normally its not possible to "steal" the control from another player,
this is only enabled if a bot controls the turret.

Known Bugs:
===========
Right now most of the known problems are occuring online only (as always.)  They are-

1) Weapon icons will revert to standard UT if using Infiltration.
2) Ammo amount for the turret won't change from 105.
3) Kick for the weapon isn't as high as offline because the player view doesn't shake.
4) Sometimes you'll loose control of the turret but your weapon won't be visible.
   Just enter the M2 radius again and exit and it should return.  (offline)


Have fun!!!

Infiltration Team