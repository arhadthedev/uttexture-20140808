                                                   VERSION 100 BETA #1
ooooo     ooo ooooooooooooo           oooo        .o.             .o8  
`888'     `8' 8'   888   `8           `888       .888.           "888  
 888       8       888       .ooooo.   888      .8"888.      .oooo888  
 888       8       888      d88' `88b  888     .8' `888.    d88' `888  
 888       8       888      888ooo888  888    .88ooo8888.   888   888  
 `88.    .8'       888      888    .o  888   .8'     `888.  888   888  
   `YbodP'        o888o     `Y8bod8P' o888o o88o     o8888o `Y8bod88P" 

      written by El Muerte [TDS]  (thekiller@cyberjunkie.com)

UTelAd is a telnet server for Unreal Tournament. You'll be able to 
administer your UT servers via telnet.

Installation:
- Copy the TDSTelnetAdmin.u en TDSTelnetAdmin.ini file to your UT 
  System directory.
- Open your UnrealTournament.ini file and add the following in the
  [Engine.GameEngine] section:

  ServerActors=TDSTelnetAdmin.TelnetListen

  and add this new section:

  [TDSTelnetAdmin.TelnetListen]
  TelnetPort=50023

  [TDSTelnetAdmin.TelnetAccept]
  Username[0]=telnetadmin
  Password[0]=mypassword
  Permissions[0]=macth

  the TelnetPort is what port you want to bind the telnet server to
  I advice not to use the default telnet port (23) for security
  reasons. In the [TDSTelnetAdmin.TelnetAccept] you can add up to
  32 user accounts.
  Here's a list of permissions:
  m = is able to say stuff on server (SAY command)
  a = can get admin status in UT
  c = able to perform console commands
  t = telnet admin (can just do a few little things)
  h = higher-level telnet admin (big time messing with the server)
  * = all permissions

You can now start your unreal tournament server. You can connect to the
telnet server with about any telnet client. Some clients work better than
others. For UNIX systems the default telnet client works great. For Windows
I advice to use CRT or SecureCRT of http://www.vandyke.com/ those are not
free but work very good. 
I will write a special telnet client designed for UTelAd later.

The server is pretty easy to use. Here's a list of functions you can use
(they are case insensitive). Some functions have multiple ways of execution
(ofcourse type them with out the `)

`HELP` or `HELP <function>`
`?` or `? <function>`
This will display all functions that you can use. If you type HELP SAY it 
will give you help about that command

`SAY <text>`
This will say something on the server, everybody can read this 
(that includes players)

`TSAY <text>`
This will only say something to other Telnet admin users

`NICK <new name>`
This changes your nick

`EXIT`
`QUIT`
`BYE`
This will close the telnet connection

`INFO`
Similar to the \INFO\ of the GameSpy protocol, it will give you basic 
information about the server

`PLAYER <player ID>`
Gives your information about player number #

`\\`
Executes the last command, including parameters

`\<new paramenters>`
Executes the last command, but uses the paramaters right after the '\\' 
(so use no space)

`/<command>`
Executes the console command right after the '/' (use no space between)

`RULES`
Similar to the \RULES\ of the GameSpy protocol, it will give you information about game settings

`BASIC`
Similar to the \BASIC\ of the GameSpy protocol, this will give you a bit of informtion about the server

`ECHO <text>`
This will repeat what you just said

`TEAM <team ID>`
This will give you information about team number #

`GETPLAYERPROP <property>`
This will return the value of the Level.Game.<game property>

`GETLEVELPROP <property>`
This will return the value of the Level.<game property>

`GETPLAYERPROP <property>`
This will return the value of the default player <property>

`LATCOMMAND`
This will return the last command you succesfully executed

`PARTYLINE`
This will display all other UTelAd users

`CONSOLECOMMAND <command>`
This will execute a console command

`WHO`
This will display information about all other UTelAd users

`MSG [1/0 or on/off or true/false]`
This will turn on/off the game message for you

`COLOR [1/0 or on/off or true/false]`
This will enable/disable the use of ANSII color codes

`LISTPLAYERS`
This will list all players with their ID

`LISTBOTS`
This will list all bots

`LISTSPECTATORS`
This will list all spectators

`TESTCOLOR`
This will give a color test

`KICKID <player ID>`
This will kick player with ID #

`KICK <name>`
This will kick the player by name

`BANID <player ID`
This will ban the player with ID #

`BAN <name>`
This will ban the player with name

`KICKBANID <player ID>`
This will kick/ban the player with ID #

`KICKBAN <name>`
This will kick/ban the player with name

`LISTGAMETYPES`
This will list all gametypes available on the server

`LISTMAPS <game type>`
This will list all maps of <game type> on the server
instead of the full gametype name you can also use the smaler versions
defined in the TDSTelnetAdmin.ini file

`LISTMUTATORS`
This will list all available mutators on the server

`LISTUSEDMUTATORS`
This will list all used mutators

`SHUTDOWNSERVER`
`SHUTDOWNSERVER <delay>`
`SHUTDOWNSERVER <delay> <message>`
This will shutdown the server in X seconds with optional message

`VIEWPERMISSIONS`
This will return your permissions on the server

`ABORT`
This will abort a server shutdown or restart

`PAUSE`
This will pause the game

`MUTATE <mutate command>`
This will execute a mutate command

`RESTARTSERVER`
`RESTARTSERVER <delay>`
`RESTARTSERVER <delay> <message>`
This will restart the server in X seconds with an optional message

`ADDMUTATOR <mutator>`
This will add a mutator to the current game

`REMOVEMUTATOR <mutator>`
This will try to remove a mutator from the game

`CHANGEMAP <map name>`
This will change the map on the server

`CHANGEGAMETYPE <game type>`
This will change the gametype on the server

`COUNT`
This will display the number of players/spectators/teams on the server


If you find any bugs or have any recommendations please email them to
thekiller@cyberjunkie.com

well have fun with this beta... Greetz El Muerte [TDS]