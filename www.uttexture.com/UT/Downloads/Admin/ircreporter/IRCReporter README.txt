// -------------------------------------------------------------------------------
// IRCReporter v1.00
// -------------------------------------------------------------------------------

*1 -- Install
*2 -- Info
*3 -- Servers
*4 -- Config
*5 -- Problems
*6 -- Notes

// -------------------------------------------------------------------------------
// 1 -- Install
// -------------------------------------------------------------------------------

Extract the contents of this archive to your UT2003/System directory.


// -------------------------------------------------------------------------------
// 2 -- Info
// -------------------------------------------------------------------------------

IRCReporter is a serverside IRC reporter bot. It will sit in an IRC channel and
report what is happening in the current match to the channel.

It's that simple.

IRCReporter requires patch 2316 (or whatever number it is ;)


// -------------------------------------------------------------------------------
// 3 -- Servers
// -------------------------------------------------------------------------------

No serverpackages needed for this, it's a serverside mutator.

Just specify the mutator in your UCC server command like so:
	UCC Server CTF-Face3&Game=UnrealGame.CTFGame&Mutator=IRCReporter.IRC_Main

And you're done!

You will want to read the configuration section below though...


// -------------------------------------------------------------------------------
// 4 -- Config
// -------------------------------------------------------------------------------

IRCReporter can be configured through three methods: Editing the INI file, console
commands while logged in as admin, and commands while it is logged in on IRC.

INI
----
For the INI file, you need to do some things manually.
Copy the text below into your server's INI file, editing it as appropriate:
(note that BotPort is the port on the IRC server it connects to).

[IRCReporter.IRC_Main]
botname=IRCReport
BotServer=irc.quakenet.eu.org
BotChannel=#IRCReporterBot.00
BotIdent=IRCBOT
BotPort=6667
ScoreFrequency=120
BotPassword=p4ssw0rd
RejoinOnKick=True
ShouldShowKills=True

Recently added are perform commands. These take the form of just as many PerformCommands=
lines as you want, followed by the command. For example:

PerformCommands=MSG [-will-] Bot Online!
PerformCommands=NOTICE [-will-] Bot Online!

it will execute both of the above. you can add as many perform commands as you want.
Supported are MSG and NOTICE. If you want to use others, you must use their raw irc form,
in which "MSG" looks like PRIVMSG Name Message.

Perform commands are executed on CHANNEL JOIN, so your bot can auth and request ops from whichever
service bot you want it to.


CONSOLE
-------
Adjustments through the console can be done after logging in as admin. Once you
are logged in you can use these commands:
	Admin Set IRCReporter.IRC_Main BotName <new name>
	Admin Set IRCReporter.IRC_Main BotServer <new server>
	Admin Set IRCReporter.IRC_Main BotPort <new Port>
	Admin Set IRCReporter.IRC_Main BotChannel <new channel>
	Admin Set IRCReporter.IRC_Main BotIdent <new ident>
	Admin Set IRCReporter.IRC_Main ScoreFrequency <time between score updates in seconds. 0 turns them off>
	Admin Set IRCReporter.IRC_Main BotPassword <NewPassword>
	Admin Set IRCReporter.IRC_Main RejoinOnKick 1/0 (1 is yes, 0 is no)
	Admin Set IRCReporter.IRC_Main ShouldShowKills 1/0 (1 is yes, 0 is no)
Commit and execute your changes using:
	Admin Set IRCReporter.IRC_Main ExecuteChanges 1
The bot will then disconnect from IRC, and reconnect with your new settings.


IRC
---
For changing settings through IRC, you use commands in the format:
	/MSG <BotName> <Password> <command>
For example:
	/MSG IRCReport p4ssw0rd BotName ISmell
The following is a list of all possible IRC commands, and what they do:
	/MSG <BotName> <Password> BotName <Newname> -- Changes the bots name.
	/MSG <BotName> <Password> BotServer <NewServer> -- Changes the bots IRC server.
	/MSG <BotName> <Password> BotIdent <NewIdent> -- Changes the bots ident.
	/MSG <BotName> <Password> BotChannel <#NewChannel> -- Changes the bots channel.
	/MSG <BotName> <Password> BotPort <NewPort> -- Changes the bots port.
	/MSG <BotName> <Password> ScoreUpdateFreq <NewFrequency> -- Changes the time between score updates (seconds). 0 turns them off.
	/MSG <BotName> <Password> ShowKills 0/1 -- (1 is yes, 0 is no)
	/MSG <BotName> <Password> RejoinOnKick 0/1 -- (1 is yes, 0 is no)
And you must use
	/MSG <BotName> <Password> ExecuteChanges
To save and execute any changes you have made.
Additionally, you can perform these commands:
	/MSG <BotName> <Password> Speak <text> -- Makes the bot speak out in-game.
	/MSG <BotName> <Password> STFU 1/0 -- Makes the bot STFU :).
	/MSG <BotName> <Password> Rejoin -- The bot will rejoin the channel
	/MSG <BotName> <Password> Op <nick> -- The bot will op the person.
There are three avaliable public commands, these are:
	.GameInfo -- Displays info about the game
	.AllScores -- Displays all scores.
	.TeamScors -- Displays team scores


// -------------------------------------------------------------------------------
// 5 -- Problems
// -------------------------------------------------------------------------------

If your bot, for some reason, fails to connect to IRC, you can tell it to re-try by
logging in as admin, and using this command:
		Admin Set IRCReporter.IRC_Main ExecuteChanges 1

If it still fails, check the following:
	-Does your server allow you to make outgoing connections to IRC servers?
	-Is it being stopepd by a firewall?
	-Is the name you have chosen for your bot taken?
	-Is the server you want it to connect to working?

... and if after all that it _STILL_ fails, email me and I'll find the problem.

Please check that the IRC server has not died/is still connectable by loading up
your IRC client, and connecting to the server yourself.


// -------------------------------------------------------------------------------
// 6 -- Notes
// -------------------------------------------------------------------------------

IRCReporter by [-will-] <will@byut.net>

Don't hesitate to email me bugs, suggestions, and comments.