AllTeams2 - by Organized Evolution - evolution@organized-evolution.com
http://www.organized-evolution.com/projects/AllTeams

Purpose
---------------------------------------------------------------------

Allteams is a mutator that allows you to use all 4 team colors in traditional
team games, such as CTF, Domination, and Assault.  It does allow you to play
with more than 2 teams, it simply allows you to pick custom colors for the
teams in team games (currently only Red, Blue, Green and Gold are available).


Installation
---------------------------------------------------------------------

Open your UnrealTournemant.ini file and add this line to your [Engine.GameEngine]
section:

ServerPackages=AllTeams2

To add AllTeams as a mutator on dedicated servers, add this line to your server's command line:
AllTeams2.ATControl




Usage
----------------------------------------------------------------------
Allteams can be configured by directly modifying the AllTeams2.ini file, 
or through mutate commands.
----------------------------------------------------------------------

INI Modification
-----------------
The AllTeams2.ini file looks like this:

[AllTeams2.ATControl]
bRandomTeamColors=True
iGameColor[0]=2
iGameColor[1]=3
debug=False


bRandomColors - Controls whether the game will randomly pick team colors
		each map ( True / False )

iGameColor[0] - Controls what the "Red" team's color will be changed to
		( 0=Red / 1=Blue / 2=Green / 3=Gold )

iGameColor[1] - Controls what the "Blue" team's color will be changed to
		( 0=Red / 1=Blue / 2=Green / 3=Gold )

debug - 	Used only for development.  Setting this to true will cause
		a massive amount of entries to your .log file, as well as to 
		every client's .log file that connects to your server.  In
		other words, LEAVE THIS SET TO FALSE!

NOTE:   If you set iGameColor to values lower than 0 or higher than 3, these
	values will be reset to valid values.


Mutate Commands
----------------
Mutate commands must be typed into the console.  You must be logged in as admin.

mutate get - Gives the valid commands for the 'get' command

mutate get randomcolors - Gives the current setting of bRandomTeamColors

mutate get teamcolors - Gives the currently configured team colors

mutate set - Gives the valid commands for the 'set' command

mutate set randomcolors - Toggles the bRandomTeamColors setting

mutate set teamcolors <team1> <team2> -

Sets the team colors to the values you specify.  You need to use the team names here. 
(Ex. mutate set teamcolors red gold)

