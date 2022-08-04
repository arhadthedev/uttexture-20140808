Specfix 1.0
by =NUB=garfield (with a LOT of help by Mongo), email: garfield-unreal@gmx.de


- What's Specfix?
Simple: It allows you to spectate matches from the player's perspective (just like you would in Quake). You always could do this in UT by typing behindview 0 at console, but there were several problems. Specfix fixes those problems.

- How do I use it?
Just copy specfix.u and specfix.int to your unrealtournament\system directory. If you want to spectate, simply go to the mod menu and check the "Spectate" entry. No need to fiddle with playersetup, specfix does this for you. Join a server and spectate. If you want to stop spectating, uncheck the menuentry and rejoin/join another server.

- This sucks, how can I uninstall it?
Just delete specfix.u and specfix.int from your unrealtournament\system directory.

- Ugh. This is a clientside mod. Will CSHP mark me as a cheater?
No. CSHP doesn't check spectators (how could a spectator cheat, anyway?). However: If you used specfix during this run of UT and used the playersetup menu to turn spectating off, you will be detected as a cheater. To avoid this, use the modmenu entry to turn off spectating. Of course, you could always just restart UT - as long as you dont touch the modmenu entry, nothing can happen.

- I've noticed a bug, what should I do?
First check the list what specfix can't do further down - if it's in there, it most likely won't be fixable. If you don't find your problem there, write to garfield-unreal@gmx.de with a description of the problem. Any suggestions/comments are welcome, too.

- Why didn't Epic do this if a Unrealscript newbie like you can do it?
Good question. Go ask Epic. :p



Known problems:

- a slight inaccuracy of the player's aim - it looks like he doesn't shoot where the crosshair is.
This is basically unavoidable. However, if you discover BIG (like half a screen) differences there and you know how to reproduce them, please contact me with a detailed explanation containing how far the aim was off, your connection quality (ping, packetloss), your average fps (in the introlevel or in utbench.dem) and if this always occurs or just on special occasions/servers.
The amount of inaccuracy will depend on your connection quality as well as the server load. On a good server with a good connection to it, inaccuracy should be hardly noticeable.

- if the player picks up a belt, it's visible for a split second.
This works like it should. It could be avoided, but might have a slight impact on performance. And it's not really a problem, is it?

- the players weapon is not displayed
Again, this works like it should. Probably unavoidable, and if it was, I'm not the one who knows how. Most players set their own weaponhand to hidden, anyway.

- Armor value displayed is always 0
Can't be fixed clientside.

- When the player moves up or down stairs (not slopes), it gets a bit jumpy.
Don't know if this is fixable in an acceptable way, but it's not a really big problem.

- When using this with Bots, all kind of weird stuff happens.
Very well possible. Specfix probably doesn't work with bots. Live with it. :)

- I'm the one guy in the world who regularly checks his Unrealtournament.log and I see some "Scriptwarning: specfix accessed none" in there.
Nice to meet you, always wondered who you were. ;p As long as there are just a few of them, don't worry. They don't hurt, and fixing them would be quite some work with no other effect then them not appearing in your log.
