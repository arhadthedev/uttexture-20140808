=============================================================================================		
 = Hez UT - Ath Server Controller v8 - ASC Winter 2006
 = For UnrealTournament 99/Classic v436/440/451 Dedicated Servers.
 = by Mickaël DEHEZ (mike@hez-studios.net)
 = HeZ Tech. Studio (http://www.hez-studios.net/)
=============================================================================================
 = for any comment, bug or resquest send an email to mike@hez-studios.net
=============================================================================================
 = version 8.25 ALPHA
 = Released: December 2005
 = compatible with PURE (tested with 7G) and EUT (read the install notes for EUT)

===============
 WHAT IS HUT ?
===============

 + An UT server is not easy to administrate ingame, you know those console commands... 
Hez-UT brings a remote window that allows you to control everything ingame, and makes server administration very easy!
It also includes a lot of features like GameVote, user administration, anti-spam, anti-teamkill, anti-respawnkill, 
enhanced chat and HUD... Well, you'd better read the long FEATURES section to know what HUT does.

note : 
	This server actor is still in development, it will help if you report bugs,
	do comments or suggest something you want in. email me: mike@hez-studios.net

==================	
 SERVER INSTALL :
==================

 + Uninstall your older version of ASC/HUT.
 
 + upload the following files to your unrealtournament/system/ folder :

	hut8cc.u
	hut825.u

 + Add packages and serveractor in your unrealtournament.ini/server.ini :
	
	[Engine.GameEngine]
	...
	ServerPackages=hut8cc
	ServerPackages=hut825
	ServerActors=hut825.hs_spawn

		! "ServerActors=hut825.hs_spawn" MUST BE AT THE BOTTOM OF THE SERVERACTOR LIST !

 + Run your server, log as server administrator, and type "mutate hz" in the console command or in the HUT window cmd input.

notes : 
	 - "mutate hz" give you all rights to configure and control your server.
	 - You'd better reconnect after you are logged as HUT Admin, it will updates all player and user lists.
	 - It is normal the GameVote TAB is empty, you must set a game.
	 - KickIdler kicks admins, if it is enabled and if you have to setup a lot of stuff on your server, do it as spectator.	
		(default is disabled)
	 - EUT ;
	If you have EUT installed, CTF TDM and DM will appear 2 times in the GameType listbox of the GameConfig TAB,
	because EUT GameTypes are named like default GameTypes. EUT GameTypes show up at the end of that list.

============	
 FEATURES :
============

	A lot of features... I will do my best to give the maximum of them there.

 +  Remote window :
	Well the window replaces command lines and shows usefull information. 
	This window is created at the begining and updated ingame, so almost all settings are shown in realtime.
	
 +  User Administration :
	With HUT, you can create, modify, delete users on your UT server. Each user can get those rights :
		+ NetWork Administrator : He is able to replicate all settings between servers.
		+ Server Administrator : He is able to excute ServerAdmin commands (Logged in HUT logs).
		+ User Administrator : He is able to edit and create users, limited by his own rights.
		+ Game Administrator : He is able to configure the server (GameVote and all others stuff).
		+ Match Administrator : He is able to control the game and players and set matches.
		+ Game Moderator : He is able to boot/kick/ban/unban. He is protected against boot/kick/ban/unban
		+ VIP : He is able to join the game even if the server is full.

 +  New accounts Security :
	I know ASC7 was easy to hack, but this time, HUT uses MD5 encryption to generate Network, Private, Public and Shared keys.
	A client logins by sending his public key to the server, the server recognizes the account corresponding to the public key.
	The server sends his NetWork key to the client which has to return a shared Key, generated with his public key,
	his private key and the NetWork key. This way, no one, and not even admins, knows clients private key, so never give it.

 +  Enhanced HUD :
	(TOP) 		A new HUD replaces the old and buggy chat. It colores words and shows usefull stuff. 
	(LEFT) 		It shows the Map ScreenShot, its author, and the server MOTD. 
	(CENTER)	It is possible for an admin to add an important message. 
	(RIGHT) 	It shows online news... well I would say it shows HUT global/world statistics. 
	Except the TOP part, those stuff disappear when the player hits fire.
	The new chat splits chat and death messages.

 +  GameVote :
	GameVote is an enhanced MapVote. It allows players to vote for their favorite gametypes, mutators, and maps.
	You can set up to 8 different games.
	When you setup a game, you choose the gametype, all mutators and all maps you want to use.
	All configurations take effect in realtime.
	You can also setup the execution of commands at the end and the begining of each game.
	Example :
		if you want a game with the CTF capture limit to 3 and another one to 6,
		you will have to set your capture limit to 3 and set the other game with those cmd lines:
		begining: set CTFGame GoalTeamScore 6
		end: set CTFGame GoalTeamScore 3
	I let you imagine what you can do with that.

 +  Match system :
	The MatchAdmin must enable it at the begining.
	New passwording system	- You can allow spectators to enter without password.
				- A client will have to set his password in the Client TAB.
				- You can send the password with the Match TAB.
	Auto-Pauser - Pause the game when the ammount of players is wrong.

 +  New pause system :
	Because the old pause blocks the chat after few secondes, HUT brings a new one.
	When an admin pauses with HUT, it does not freez UT : 
	It saves the remaining time and players location, and put them to a spectator state.
	When the game is resumed, all players are set as player and are returned to their original location.
	
 +  Game control system :
	You can force the game to :
		- start
		- pause
		- end/vote
		- restart

 +  Player control system :
	You can force a player to :
		- Change his team
		- Reconnect as spectator
		- Reconnect as player
		- reconnect on another server (the server will save last servers used)
		- send the password

 +  Moderator commands :
	Like every admin module, HUT has boot, kick, ban, unban functions.
	You can control the ammout of game you want to ban.
	You must give a reason to kick.
	It shows the list of banned players that you can update.

 +  Client commands :
	TeamBalancer - Balance Teams...
	GameVote request - Vote to run GameVote. 
		if more than 50% of players want it, then the game stops and everyone vote for the next.
	KickVote - Vote to kick a player (you can't kickvote or even kick a moderator).
		if more than 50% of players want it, the player is kicked for the ammount of games you have set.
	Quick Commands - disconnect/reconnect/blue/red... everything a client needs.
	All those commands can be used with the "IRC fashion". (e.g. !red !spec, shortcut : !r !s)

 +  Enhanced Tournament MOD :
	The Tournament MOD is enabled with HUT. But only one player has to say !start or press FIRE to start the game.
	When a MatchAdmin is ingame, only him will be able to start the game.
	There is also a value in secondes you can set to wait players (while this delay it won't be possible to start the game).

 +  Ingame Protections :
	Respawn protection - it protects you while few secondes after you have respawned.
	Sh0ck protection - it protects you while few secondes after a teammate hit you.
	Push protection - it protects you but only from lava, fall... while few secondes after a teammate hit you.

 +  Enhanced Death :
	It is possible to set the delay that a player will wait after he died. 
	The player will spectate while the delay you have set.

 +  Anti-Spam :
	The anti-spam also checks voice taunts. You can set the muted delay between each taunts.
	It disallows to say 2 times the same thing and to say 3 things while few secondes.

 +  Names restriction :
	You can disallow certain words in names.
	Only trusted users will be allowed to use those words in their names.
	It is usefull to protect a clan tag.

 +  Kick-Idler :
	Based on players location. You can setup the delay before kicking idler.
	note that with a small kick delay, it could be an anti-camper.

 +  ServerAdmin commands :
	Only for HUT Server Administrator.
	You can execute any UT Server Admin command even if you are not lgged in.
	You must use the HUT remote window and check admin in client TAB.
	It is not the server console, you have to type "admin" before "set" or "get" commands.
	e.g. "mutate utdc sshot", "admin set GameInfo MaxSpectators 8".
	Cheat commands are disabled (ghost, god, allammo ...).
	you can also bind a key in user.ini with "mutate hz701{YOURCOMMAND}", e.g. :
		...
		F3=ShowObjectives
		F4=mutate hz701mutate utdc sshot
		F5=ViewTeam
		...

 +  Colored Teams :
	All Players are colored with their team color.
	It is brighter if the shield is activ.	

 +  Reserved Slots :
	VIP are able to login as player even if the server is full.
	BUT, most of you are renting a server, if you enable this feature, please read that:
		! YOU HAVE TO REDUCE THE MAXPLAYERS VALUE IN ORDER TO USE THE RESERVED SLOTS FEATURE !
	Example: If you are renting a 12 slots server, reduce your server to 10 and set the HUT playerlimit to 12.
		 If your provider see 13/12 for a 12 slots server, he will shutdown your server.
	if your HUT players limit is 12 and your server is 10 players, you will have 2 reserved slots.

 +  Auto reconnect :
	Reconnect all clients when your server has crashed.
	You can setup the delay that the client will wait before he reconnects.
	Set a long delay if your server is slow (10 secondes), 
	or a short delay for a 10Ghz pentium 6 (5 secondes).
	When you update your server and if you want the auto reconnect working while rebooting :
		Type "debug gpf" in the console command and NOT "exit" !
		exit will close all connections and the auto reconnect won't work.
	I believe you can use your custom webmin to reboot because it crashes the server.

 +  Ingame && Dynamic Log :
	HUT has his own log. It logs HUT events, warnings and errors. (Log TAB)
	Warnings and errors are saved in hut_log.ini (up to 64 warnings/errors). Only admins see them.
	The server will noticed admins if the log contains errors at the begining of the game.

 +  PURE Flag Fix :
	CTF Flags are not more black, and no, I am not racist :)

 +  Enhanced Server Querying :
	HUT opens a HTTP connection on your server game port (default is TCP-7777, http://SERVERADDRESS:7777/).
	You can query your server from a webserver that does not have PHP sockets enabled!
	Check the /hut_query folder included in this pack to use this feature.
	e.g. www.nuclearunreal.com use it. (home page)

 +  Global statistics :
	Your server will communicate with a master server and it will generate statistics for your server.
	visit http://www.hez-studios.net/			

=====================================
 What might be in the next version ?
=====================================

 + Something to Delete hut_log.
 + Something to Disable the last played games like for maps.
 + Something to Import a configured game to the Vote-Config TAB.
 + Something to Bind keys for MatchAdmin (stop,pause,restart,...).
 + Add faces in HUD.
 - Fix the server console and client messages.
 + Load more than 256 maps.
 + Accumulation for GameVote.
 + NetWork TAB : replication between servers (users,games,settings).
 + Chat TAB : PM, IRC.
 + Manual ban.
 + A lot of disable/enable configurations :*).
 - Only kick idlers when the server is full.
 + Personal statistics (?).

And most of the things you will email me or post in the forum.

============================
 TEST & POPULATED SERVERS :
============================

-NUCLeARUNReAL-StrangeLove-Orleans-
	unreal://82.229.114.109:7777/
-NUCLeARUNReAL-StrangeLove-Paris-
	unreal://82.98.225.112:7777/?password=nuclear
	
================
 Download URL :
================

	http://ursclan.free.fr/files/hut825.zip
	www.unrealadmin.org
	
===========
 CREDITS :
===========

 + BattleField Vietnam : Sounds & Enhanced death idea.
 + cedric Megnat : ASC7&8 replications, HUD.
 + Bruce Bickar : MapVote && Window.
 + Bruce Bickar, [TTH]PJMODOS, Major Disaster : For giving us good examples.
 + All beta testers (all NUCLeARUNReAL's players).
 + Matthew : ASC7 public release.
 + And of course the UnrealWiki community and www.unrealadmin.org.
