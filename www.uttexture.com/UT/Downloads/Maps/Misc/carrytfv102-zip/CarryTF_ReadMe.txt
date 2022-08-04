=================================
   C a r r y   T h e   F l a g
=================================
      v1.02

Nexus Entertainment

http://www.utworld.net/nexus
versix@utworld.net
ICQ UIN: 69695724 (Versix)

Installation
------------
If you have had an old version of Carry The Flag installed on your system, you must uninstall it before installing this version, or you might get some errors. If you had a umod version, just use Add/Remove Programs to uninstall it, but if you had a zipped version you must delete these files:

System\CarryTF.u
System\CarryTF.int

You also must REMOVE the following line from unrealtournament.ini:

ServerPackages=CarryTF


Now on to installation...

Carry The Flag requires UT 413, however the umod will let you install even if you have a lower version. This is to prevent people who actually do have 413 getting errors when they install. If you have the umod version, double-click it or run it or whatever.

If you have the non-umod version, then unzip all files into your system directory (overwrite if needed). I prefer to put the readme in the help directory, but do as you please. After that, if you will be running a server (listen or dedicated), open unrealtournament.ini (in the system directory) and add this to the [Engine.GameEngine] section:

ServerPackages=CarryTFv102

After that everything should work fine. If it does not, email me at versix@utworld.net.

Information
-----------

Carry The Flag is CTF like it should have been. You can't return your flag by simply touching it, you have to carry it back to your base yourself. There are also a lot of extra options for changing the way CarryTF is played. You set these options from the rules menu, or from UnrealTournament/System/CarryTFv102.ini if you are running a Linux server. You should read these before you play, so you know what's happening.

ENABLE DROPCAP: Turn this on and you can score by taking the enemy flag to your own flag, no matter where it is. For exmaple, you could grab you own flag, drop it outside the enemy base, run in and get their flag, then run back out and capture the enemy flag by touching your own flag that is just lying there on the ground.

CAPTURE WITHOUT FLAG: With this enabled, you can capture the enemy flag even if you flag is not at base. Recommended with Team Fortress mode.

TAKE FRIENDLY FLAG: If this is enabled, then you can take your own flag from it's base by pushing the Pickup/Drop Flag key (configured at the keyboard setup page), so you can run around with your own flag just for the hell of it. Or to try and dropcap.

BOTS DROPCAP: With this enabled bots will attempt to dropcap, so don't be surprised if you see them taking their own flag and storming your base.

TEAM FORTRESS MODE: Check this to have CarryTF play like Team Fortress. You can't carry your own flag, there is no way to get it to return to base except for waiting for it to respawn. So you have to guard it from the enemy while you wait for it to get sent back to base.

DROPPED FLAG TIMEOUT: This is the number of seconds the flag can lie on the ground before it is automatically sent back to the base. Set it to zero to have the flag never get sent back... this might cause some problems with the flag getting lost if something weird happens though. But nothing like that has ever happened during my testing.

TF FREEZE TIMER: If this is enabled, the timer will not reset when the flag is picked up by an enemy in Team Fortress mode. It simply freezes, making it easier to return the flag. Recommended if Capture without Flag is off.

SEND TO PATHNODE: With this options checked, the flag will not return to base if it is dropped in lava or slime. Instead it will be moved to the nearest PathNode. Use this option to prevent people suiciding on maps like LavaGiant to get their flag back to base.

You have to set up the Pickup/Drop Flag key if you want to use the Take Friendly Flag option. To do this just go to the keyboard setup window and scroll all the way to the bottom. The FlagToggle key will make you:
- drop a flag if you are holding one
- take the friendly flag if you are standing next to it
- return the friendly flag to base if you are standing near the base and you took the flag from the base (ie: you didn't get it from the enemy)

Some recommended options congifurations:

Carry The Flag
Leave all options off, and set Dropped TimeOut to 0. This is just regular CTF without magic teleporting flags.

Dropcap The Flag (Bad name, but what am I supposed to call it?)
Turn on Dropcap, Take friendly flag, Bot Dropcap and leave Dropped TimeOut at 0. This will create a faster paced and less base orientated CTF.

Team Fortress CTF
Team Fortress on (duh...), Cap without flag on, Dropped Timeout at 60. Pretend you are playing TFC.

Send all suggestions/bugs you have to versix@utworld.net. If you want to run a Carry The Flag server, tell me and I'll link to the server on my site.


Credits
-------

Programmer: Versix
Beta Testers: Theta-Nine, Unleaded, Hert (and whoever played at a LAN with them). Thanks guys! Also, special thanks to Christian Neub for his ngStats assistance.


Version History
---------------

Changes since v1.01

- Fixed UT 420 incompatabilities, you can now cap the flag with the patch.
- ngStats now processes Carry The Flag games as CTF games, not Tournament Deathmatch. The game type will appear as Capture the Flag in ngStats though, so don't get confused.
- Fixed bug that prevented TF Freeze Timer and Send to PathNode options from displaying in the rules page for a network game.
- Added a little teleport effect for flags disappearing.
- Stopped bots from facing the wrong way on rare occasions when defending a dropped flag in Team Fortress mode.
- When you push the drop/pickup flag key, now it will be thrown a little way in front of you intead of being dropped behind you.
- Changed package name to reflect version number for easier auto-downloading.
- Also, there should now be 50% less occurances of bots running the wrong way. This was extremely rare anyway, so you probably won't see any change. I can't make a proper fix in this version because of lack of time (exams are on now), it will be completely fixed in 1.03.
- Made it possible to play in TF mode with a timeout of 0, which works well and makes "mobile bases". Make sure you try it.
- Edited send to pathnode a bit that no one will notice.

Changes since v1.00

- Fixed flag status indicator bug (online only) that caused accessed nones in the client's log and made all "!"s appear red.
- Added new option to make flag go to nearest pathnode and not return to base when it is in a painzone (lava, slime etc).

Changes since v.90

- Renamed some options.
- Can now set up options from CarryTF.ini.
- Added Team Fortress mode and related options.
- Added options to stop bots dropcapping.
- Improved flag status indicators on the right side of the HUD ( The "!" is now the color of who holds the flag, and it displays how long the flag has left before it respawns).
- Improved bot dropcap AI.
- Fixed UT 413 incompatabilities (and removed mutator because of it):
  - Not being able to capture flag.
  - Flags multiplying.
  - Everything else going to hell (yeah, I *can* fix that :).
- Fixed mutate() function bug that was stopping other keys from working.
- Fixed bots and humans taking friendly flag when option was disabled.
- Moved options to rules page, and keyboard setup to the proper setup page.
- Added a server browser.
- Removed mod menu item.
- Set scoreboard to display last capture spot if it was a dropcap.
- Fixed bots running on spot in some occasions.
- Set bots CombatStyle to avoidant when they have a flag  .
- More stuff I don't remember right now.

Changes since v.75

- The Dropped TimeOut setting actually works this time.
- If you touch the enemy flag at it's base while holding your own flag, your flag no longer disappears. You just can't pickup the enemy flag.
- Bot AI for Capture at Friendly Flag. They work a lot more as a team now, and even take their own flag into enemy territory if they're confident. You'll see...
- The messages at the bottom of the screen are now Carry The Flag specific.


Copyright 2000 Nexus Entertainment
You may redistribute Carry The Flag as long as you include all files unedited and intact. If you make it available on your site or anything else, please let me know. You can change my code and use it in your own mods, but I would prefer it if you notified me first. Any failure to comply with these rules will result in immediate self-combustion.