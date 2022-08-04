MapVote Version 4.00 beta 6
Created By BDB (Bruce Bickar)

Please visit my web site http://www.planetunreal.com/BDBUnreal
You can post questions, problem reports, and comments on the message board/forum.

Note: This version will only work on a dedicated server.

Installation instructions:
===========================
1. Save MapVote400b6.int and MapVote400b6.u in the \UT2003\System directory.

2. Copy and paste these ini settings into your \UT2003\System\UT2003.ini (at the bottom)
--------------------------------------------------------------------------
[MapVote400b6.MapVote]
VoteTimeLimit=70
ScoreBoardDelay=10
bAutoOpen=True
MidGameVotePercent=50
RepeatLimit=4
MapVoteHistoryType=MapVote400b6.MapVoteHistory1
GameConfig=(GameClass="XGame.xDeathMatch",Prefix="DM",GameName="DeathMatch",bUseMapList=false,Mutators="")
GameConfig=(GameClass="XGame.xTeamGame",Prefix="DM",GameName="Team DeathMatch",bUseMapList=false,Mutators="")
GameConfig=(GameClass="XGame.xDoubleDom",Prefix="DOM",GameName="Double Domination",bUseMapList=false,Mutators="")
GameConfig=(GameClass="XGame.xCTFGame",Prefix="CTF",GameName="Capture The Flag",bUseMapList=false,Mutators="")
GameConfig=(GameClass="XGame.xBombingRun",Prefix="BR",GameName="Bombing Run",bUseMapList=false,Mutators="")
--------------------------------------------------------------------------- 
You can delete the "GameConfig" lines that you dont want. 

Settings explaination:
   VoteTimeLimit - A number between 1 and 500. The number of seconds to allow for voting 
                   at the end of the game or after a Mid-Game vote. After this time limit
                   has been reached the votes are counted and the map with the highest score
                   wins. Default is 70

   ScoreBoardDelay - A number between 1 and 500. The number of seconds to delay before automatically
                     opening the voting window after the end of the current game is reached.
                     This time is given to the players so that they can look at the score board.
                     Default is 10.

   bAutoOpen - True or False. If true then the voting windows will be automatically opened at the end
               of each game. If False then the normal cycle maplist is used to select the next map.
               Players can initiat a Mid-Game vote only. They would have to open the voting window
               by pressing the MapVote HotKey. Default hotkey is the HOME key. This can be changed
               on the "Configuration" tab window.
               Default is True.

   MidGameVotePercent - A number between 1 and 100. The percentage of players that are required to
                        vote before a Mid-Game vote is initated. Set to 100 to virtually disable
                        Mid-Game voting by requiring all of the players to vote.
                        Default is 50.

   RepeatLimit - A number between 0 and the total number of maps on the server. 
                 The number of games to disabe voting for a map after it has been played.
                 Default is 4                                  

   MapVoteHistoryType - The code class that manages the map history data.
                        This can be set to one of 4 settings.
                           MapVoteHistoryType=MapVote400b6.MapVoteHistory1
                           MapVoteHistoryType=MapVote400b6.MapVoteHistory2
                           MapVoteHistoryType=MapVote400b6.MapVoteHistory3
                           MapVoteHistoryType=MapVote400b6.MapVoteHistory4
                        
                        The default is "MapVoteHistoryType=MapVote400b6.MapVoteHistory1"
                        MapVoteHistory1 will create a file in the system directory
                        named MapVoteHistory1.ini where the history data is stored. 
                        MapVoteHistory2 will create MapVoteHistory2.ini etc...
                        
                        If you run more than one UT server session on the same physical server
                        then change this setting in each ini file so that each UT server session 
                        uses a different/unique MapVoteHistoryType. 

GameConfig settings explaination:
   Note: You can add an infinite number of GameConfig lines in you ini file. Just keep in mind
         that the more you add the more maps will be loaded in the maplist. The more maps the
         longer it will take to send the complete maplist to each player. It will also take
         longer for the server to load the maplist at the beginning of each map. 
   GameClass - This is the name of the package and the name the game class 
               separated by a period. Example: "XGame.xCTFGame". 

               Here are the out-of-the-box game classes:
                 DeathMatch is "XGame.xDeathMatch"
                 Team DeathMatch is "XGame.xTeamGame"
                 Double Domiation is "XGame.xDoubleDom"
                 Capture The Flag is "XGame.xCTFGame"
                 Bombing Run is "XGame.xBombingRun"

               For new games/Mods the gameclass can be found in the *.int file that comes 
               with it. Look for something similar to this:
               =============================================================================                
               Object=(Class=Class,MetaClass=Engine.GameInfo,Name=XGame.xDeathMatch,Description="DM|DeathMatch|xinterface.Tab_IADeathMatch|xinterface.MapListDeathMatch|false")
                                                                  #################
               =============================================================================   

   Prefix - The MapName Prefix to load when bUseMapList is set to False. This tells MapVote 
            which maps to load in the maplist for this gametype. example: "CTF" for Capture the Flag.

   GameName - This is the name or title of the game type. For example: "Capture The Flag".
              Note: You can make this anything you like. Example: "Dont Touch My Flag" 

   bUseMapList - True or False. If True then the map names are loaded from the
                 MapList that is in the User (or specified user) ini file. 
                 If False then all available maps (that have the specified Prefix) are loaded. 
                 For example: If the game type is CTF and bUseMapList is True then map names 
                 will be loaded for this: (if this was your servers ini file)
                 \UT2003\System\User.ini
                 =============================================================================
                 [XInterface.MapListCaptureTheFlag]
                 MapNum=1
                 Maps=CTF-Chrome
                 Maps=CTF-Citadel
                 Maps=CTF-December
                 Maps=CTF-Face3
                 Maps=CTF-Geothermal
                 Maps=CTF-LostFaith
                 Maps=CTF-Magma
                 Maps=CTF-Orbital2
                 =============================================================================

   Mutators - List of Mutators to load with this game type. If more than one separate each
              with a comma.
              Example: "MapVote400b6.MapVote,XGame.MutInstaGib,UnrealGame.MutBigHead,UnrealGame.MutLowGrav"
              If this is set blank ("") then only the current mutators are loaded.
              WARNING: If you set mutators for any GameConfig you MUST include the base mutators 
                       in ALL of the GameConfigs. This includes MapVote.
                       If you leave all of them blank then the base mutators will stay.

Example GameConfig:
GameConfig=(GameClass="XGame.xCTFGame",Prefix="CTF",GameName="Dont Touch My Flag",bUseMapList=false,Mutators="MapVote400b6.MapVote,KickIdlersUT2003V1b.KickIdlers")
GameConfig=(GameClass="XGame.xCTFGame",Prefix="CTF",GameName="CTF LowGrav/InstaGib",bUseMapList=false,Mutators="MapVote400b6.MapVote,KickIdlersUT2003V1b.KickIdlers,XGame.MutInstaGib,UnrealGame.MutBigHead,UnrealGame.MutLowGrav")

GameConfig=(GameClass="XGame.xBombingRun",Prefix="BR",GameName="Ball In Hole",bUseMapList=false,Mutators="MapVote400b6.MapVote,KickIdlersUT2003V1b.KickIdlers")
GameConfig=(GameClass="XGame.xBombingRun",Prefix="BR",GameName="BR LowGrav/InstaGib",bUseMapList=false,Mutators="MapVote400b6.MapVote,KickIdlersUT2003V1b.KickIdlers,XGame.MutInstaGib,UnrealGame.MutBigHead,UnrealGame.MutLowGrav")
                         


3. Add "ServerPackages=MapVote400b6" to your UT2003.ini file in the "[Engine.GameEngine]" section.
Example: (* Dont copy this section, yours may be different.)
---------------------------------------------------------------------------
   [Engine.GameEngine]
   CacheSizeMegs=32
   UseSound=True
   ServerActors=IpDrv.MasterServerUplink
   ServerActors=UWeb.WebServer
   ServerPackages=Core
   ServerPackages=Engine
   ServerPackages=Fire
   ServerPackages=Editor
   ServerPackages=IpDrv
   ServerPackages=UWeb
   ServerPackages=GamePlay
   ServerPackages=UnrealGame
   ServerPackages=XEffects
   ServerPackages=XPickups
   ServerPackages=XGame
   ServerPackages=XWeapons
   ServerPackages=XInterface
   ServerPackages=Vehicles
   ServerPackages=TeamSymbols_UT2003
*->ServerPackages=MapVote400b6
   MainMenuClass=XInterface.UT2MainMenu
   ConnectingMenuClass=XInterface.MenuConnecting
   DisconnectMenuClass=XInterface.UT2NetworkStatusMsg
   UseStaticMeshBatching=True
---------------------------------------------------------------------------

4. Command line mutator name is "MapVote400b6.MapVote"
Example: 
---------------------------------------------------------------------------
ucc server CTF-Citadel.ut2?game=XGame.xCTFGame?mutator=MapVote400b6.MapVote
---------------------------------------------------------------------------
Note: you can use the example batch file supplied. MapVoteServer.bat



