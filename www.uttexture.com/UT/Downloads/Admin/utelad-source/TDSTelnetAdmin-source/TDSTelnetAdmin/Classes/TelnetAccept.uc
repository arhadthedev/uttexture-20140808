// replies
// [~] is just a message
// [N] is information reply
// [M] server message
// [e] echo
// [E] error
// [C] console command return
// [H] help reply

class TelnetAccept expands TcpLink config;

var TelnetSpectator Spectator;
var TelnetListen Listner;
var TelnetDefines defines;

const VERSION = "101 BETA";
const PROTOCOL_VERSION = "100";

//semi constants
var string CRLF;
//ansi colors
var string clReg;
var string clBlack;
var string clGray;
var string clMaroon;
var string clRed;
var string clGreen;
var string clLime;
var string clOlive;
var string clYellow;
var string clNavy;
var string clBlue;
var string clPurple;
var string clMagenta;
var string clCyan;
var string clAqua;
var string clSilver;
var string clWhite;

var globalconfig string Username[32];
var globalconfig string Password[32];
// permission
// m = is able to say stuff on server (SAY command)
// a = can get admin status in UT
// c = able to perform console commands
// t = telnet admin
// h = higher-level telnet admin (big time messing with the server)
// * = all permissions
var globalconfig string permissions[32];
// messages
// * = all messages
// t = team messages
// v = voice messages
// l = localized messages
// c = client messages
var globalconfig string messages[32];

var string uname; //user name
var bool authorized; 
var string lastcommand;
var string command;
var bool msgon; //messages on
var int logintries; //number of tries of login
var string perms; //permissions of user
var string msgs; //messages of user
var int id; //id of the user

var private int ShutDownTime;
var private string ShutDownMsg;
var private bool bShutDownTick;
var private bool bRestartTick;
var private int lastShutDownMsg;
var private string rurl;

function send(string s) //send with a CR/LF at the end
{   sendText(s $ CRLF);
}

function bool getPerm(string perm)
{   if (InStr("*",perms) == -1) return true;
    return (InStr(Caps(perm),Caps(perms)) == -1);
}

function string GetValueString(string s)
{
   return Mid(s,InStr(s,"=")+1);
}

function string GetNameString(string s)
{
   return Left(s,InStr(s,"="));
}

function setup(bool color) //set semi constants
{
    CRLF = Chr(13)$Chr(10);
    
    if (color)
    {
        clReg = Chr(27)$"\[0;0m";
        clBlack = Chr(27)$"\[0;30m";
        clGray = Chr(27)$"\[1;30m";
        clMaroon = Chr(27)$"\[0;31m";
        clRed = Chr(27)$"\[1;31m";
        clGreen = Chr(27)$"\[0;32m";
        clLime = Chr(27)$"\[1;32m";
        clOlive = Chr(27)$"\[0;33m";
        clYellow = Chr(27)$"\[1;33m";
        clNavy = Chr(27)$"\[0;34m";
        clBlue = Chr(27)$"\[1;34m";
        clPurple = Chr(27)$"\[0;35m";
        clMagenta = Chr(27)$"\[1;35m";
        clCyan = Chr(27)$"\[0;36m";
        clAqua = Chr(27)$"\[1;36m";
        clSilver = Chr(27)$"\[0;37m";
        clWhite = Chr(27)$"\[1;37m";
    }
    else {
        clReg = "";
        clBlack = "";
        clGray = "";
        clMaroon = "";
        clRed = "";
        clGreen = "";
        clLime = "";
        clOlive = "";
        clYellow = "";
        clNavy = "";
        clBlue = "";
        clPurple = "";
        clMagenta = "";
        clCyan = "";
        clAqua = "";
        clSilver = "";
        clWhite = "";
    }
}

function Figlet()
{   send(clYellow$"ooooo     ooo oooooooooo"$clLime$"ooo           oooo "$clRed$"       .o.             .o8  "$clReg);
    send(clYellow$"`888'     `8' 8'   888 "$clLime$"  `8           `888 "$clRed$"      .888.           \"888  "$clReg);
    send(clYellow$" 888       8       888"$clLime$"       .ooooo.   888 "$clRed$"     .8\"888.      .oooo888  "$clReg);
    send(clYellow$" 888       8       88"$clLime$"8      d88' `88b  888 "$clRed$"    .8' `888.    d88' `888  "$clReg);
    send(clYellow$" 888       8       8"$clLime$"88      888ooo888  888 "$clRed$"   .88ooo8888.   888   888  "$clReg);
    send(clYellow$" `88.    .8'       "$clLime$"888      888    .o  888 "$clRed$"  .8'     `888.  888   888  "$clReg);
    send(clYellow$"   `YbodP'        "$clLime$"o888o     `Y8bod8P' o888o"$clRed$" o88o     o8888o `Y8bod88P\" "$clReg);
}

event Accepted()
{   
    Disable('Tick');
    setup(true);
    if (Listner != none) defines = Listner.defines;
      else defines = spawn(class'TDSTelnetAdmin.TelnetDefines');
    command = "";
    msgon = true;
    logintries = 0;
    log("[~] connection opened from : "$IpAddrToString(RemoteAddr));
    send("["$clYellow$"UT"$clReg$"-"$clLime$"Telnet"$clReg$"-"$clRed$"Admin"$clReg$"]"); //header
    send(clGray$"["$PROTOCOL_VERSION$"-"$VERSION$"]"$clReg); //protocol-program version
    Figlet(); // nice logo
    send("written by "$clMagenta$"El Muerte [TDS]"$clReg$"  ("$clBlue$"thekiller@cyberjunkie.com"$clReg$")");
    send("["$clMaroon$"---------------"$clReg$"]"); //start of protocol
    uname = "";
    authorized = false;
    sendText(Chr(7));
    if (!authorized) sendText("["$clMagenta$"~"$clReg$"] Username: ");
}

event Closed()
{   LeavePartyLine();
    if (Spectator != None) Spectator.Destroy();
    log("[~] connection closed at : "$IpAddrToString(RemoteAddr));
    Destroy();
}

event Timer()
{	Close();
}

function string trim(string ln) // trim controlcharacters
{   
    local string result;
    local int i;
    i = 0;
    while (i < len(ln))
    {
        if (mid(ln,i,1) > Chr(31))
        {   result = result$mid(ln,i,1);
        }
        i++;
    }

    return result;
}

function ProcTELNET( string ln)
{   
    local string cmd;
    local bool third;
    local int i;
    third = false;

    while (ln != "")
    {
        if (Mid(ln,1,1) == Chr(240))
        {   cmd = "TELNET : SE";
        }
        if (Mid(ln,1,1) == Chr(241))
        {   cmd = "TELNET : NOP";
        }
        if (Mid(ln,1,1) == Chr(242))
        {   cmd = "TELNET : DM";
        }
        if (Mid(ln,1,1) == Chr(243))
        {   cmd = "TELNET : BRK";
        }
        if (Mid(ln,1,1) == Chr(244))
        {   cmd = "TELNET : IP";
        }
        if (Mid(ln,1,1) == Chr(245))
        {   cmd = "TELNET : AO";
        }
        if (Mid(ln,1,1) == Chr(246))
        {   cmd = "TELNET : AYT";
        }
        if (Mid(ln,1,1) == Chr(247))
        {   cmd = "TELNET : EC";
        }
        if (Mid(ln,1,1) == Chr(248))
        {   cmd = "TELNET : EL";
        }
        if (Mid(ln,1,1) == Chr(249))
        {   cmd = "TELNET : GA";
        }
        if (Mid(ln,1,1) == Chr(250))
        {   cmd = "TELNET : SB ";
            third = true;
        }
        if (Mid(ln,1,1) == Chr(251))
        {   cmd = "TELNET : WILL ";
            third = true;
        }
        if (Mid(ln,1,1) == Chr(252))
        {   cmd = "TELNET : WONT ";
            third = true;
        }
        if (Mid(ln,1,1) == Chr(253))
        {   cmd = "TELNET : DO ";
            third = true;
        }
        if (Mid(ln,1,1) == Chr(254))
        {   cmd = "TELNET : DONT ";
            third = true;
        }
        if (Mid(ln,1,1) == Chr(255))
        {   cmd = "TELNET : 255 ";
        }
        if (cmd == "") cmd = "TELNET : unkown";

        if (third)
        {   if (Mid(ln,2,1) == Chr(1))
            {   cmd = cmd$"echo";
                if (Mid(ln,1,1) == Chr(253)) //do echo
                {   //sendText(Chr(255)$Chr(252)$Chr(1)); //wont echo
                    //sendText(Chr(255)$Chr(253)$Chr(1)); //DO ECHO
                }
            }
            if (Mid(ln,2,1) == Chr(3))
            {   cmd = cmd$"suppress go ahead";
            }
            if (Mid(ln,2,1) == Chr(5))
            {   cmd = cmd$"status";
            }
            if (Mid(ln,2,1) == Chr(6))
            {   cmd = cmd$"timing mark";
            }
            if (Mid(ln,2,1) == Chr(24))
            {   cmd = cmd$"terminal type";
                if (Mid(ln,1,1) == Chr(251))
                {
                    //sendText(Chr(255)$Chr(253)$Chr(24)); //get term type
                    //sendText(Chr(255)$Chr(250)$Chr(24)$Chr(1)$Chr(255)$Chr(240));
                }
                if (Mid(ln,1,1) == Chr(250))
                {   //ln = Left(ln,3)$Mid(ln,4);
                    //log(len(ln));
                    //log(Mid(ln,5));
                }
            }
            if (Mid(ln,2,1) == Chr(31))
            {   cmd = cmd$"window size";
            }
            if (Mid(ln,2,1) == Chr(32))
            {   cmd = cmd$"terminal speed";
            }
            if (Mid(ln,2,1) == Chr(33))
            {   cmd = cmd$"remote flow control";
            }
            if (Mid(ln,2,1) == Chr(34))
            {   cmd = cmd$"linemode";
            }
            if (Mid(ln,2,1) == Chr(36))
            {   cmd = cmd$"environment variables";
            }
            ln = Mid(ln,3);
        }
        else ln = Mid(ln,2);
        i = InStr(ln,Chr(255));
        if (i != -1)
        {   //log(cmd$" + "$Trim(Mid(ln,0,i)));
            ln = Mid(ln,i);
        }
        else
        {   
            //log(cmd$" + "$Trim(ln));
        }
    }
}

event ReceivedText( string Line )
{   
    if (Left(Line,1) == Chr(255))
    {   ProcTELNET(Line);
        return;
    }
    command = command$Trim(Line);
    if (InStr(line,Chr(13)) == -1)
    {   return;
    }
    else
    {   if (command != "") Line = command;
    }
    command = "";
    line = trim(Line);
    if ((Line == "") && (authorized))
    {   return;
    }
    if (!authorized) 
    {   
        if (logintries > 2) 
        {   Close();
            return;
        }
        if (uname == "")
        {   
            logintries++;
            if (GetName(Line)) 
            {   uname = Line;
                sendText("["$clMagenta$"~"$clReg$"] Password: ");
                sendText(Chr(255)$Chr(251)$Chr(1));
            }
            else 
            {   
                send("["$clMagenta$"~"$clReg$"] incorrect username");
                if (logintries > 2) 
                {   Close();
                    return;
                }
                sendText("["$clMagenta$"~"$clReg$"] Username: ");
                sendText(Chr(7));            
            }
        } 
        else 
        {   
            sendText(Chr(13)$Chr(10));
            if (GetPassword(Line)) 
            {   authorized = true;
                send("["$clMagenta$"~"$clReg$"] login succesfull");
                sendText(Chr(7)$Chr(255)$Chr(252)$Chr(1));
                Spectator = Spawn(class'TelnetSpectator');
                Spectator.setTA(self);
                Spectator.PlayerReplicationInfo.PlayerName = uname;
                JoinPartyLine();
                setMessages(msgs);
                Log("[~] "$uname$" logged in");
            }
            else 
            {
                authorized = false;
                uname = "";
                send("["$clMagenta$"~"$clReg$"] incorrect login");
                if (logintries > 2) 
                {   Close();
                    return;
                }
                sendText("["$clMagenta$"~"$clReg$"] Username: ");
                sendText(Chr(7)$Chr(255)$Chr(252)$Chr(1));

            }
        }
        return;
    }

    else if (line ~= "\\\\")
    {   line = lastcommand;
    }
    else if (Left(line,1) ~= "\\")
    {   if (InStr(lastcommand," ") > -1)
        {   line = Left(lastcommand,InStr(lastcommand," "))$" "$Mid(Line,1);
        }
        else Line = lastcommand$" "$Mid(Line,1);
    }
    if (Line == "") 
    {   return;
    }
    if (Left(Line,4) ~= "INFO")
    {   ProcINFO(Line);
    } 
    else if (Left(Line,7) ~= "PLAYER ")
    {   ProcPLAYER(Line);
    }
    else if (Left(Line,5) ~= "RULES")
    {   ProcRULES(Line);
    }
    else if (Left(Line,5) ~= "BASIC")
    {   ProcBASIC(Line);
    }
    else if (Left(Line,5) ~= "ECHO ")
    {   ProcECHO(Line);
    }
    else if (Left(Line,5) ~= "TEAM ")
    {   ProcTEAM(Mid(Line,5));
    }
    else if (Left(Line,4) ~= "HELP")
    {   ProcHELP(Mid(Line,5));
    }
    else if (Left(Line,1) ~= "?")
    {   ProcHELP(Mid(Line,2));
    }
    else if (Left(Line,4) ~= "EXIT")
    {   ProcEXIT();
    }
    else if (Left(Line,4) ~= "QUIT")
    {   ProcEXIT();
    }
    else if (Left(Line,3) ~= "BYE")
    {   ProcEXIT();
    }
    else if (Left(Line,5) ~= "COUNT")
    {   ProcCOUNT(line);
    }
    else if (Left(Line,4) ~= "SAY ")
    {   ProcSAY(line);
    }
    else if (Left(Line,5) ~= "ESAY ")
    {   ProcESAY(line);
    }
    else if (Left(Line,5) ~= "TSAY ")
    {   ProcTSAY(line);
    }
    else if (Left(Line,5) ~= "NICK ")
    {   ProcNICK(line);
    }
    else if (Left(Line,12) ~= "GETGAMEPROP ")
    {   GetGameProperty(line);
    }
    else if (Left(Line,13) ~= "GETLEVELPROP ")
    {   GetLevelProperty(line);
    }
    else if (Left(Line,14) ~= "GETPLAYERPROP ")
    {   GetPlayerProperty(line);
    }
    else if (Left(Line,11) ~= "LASTCOMMAND")
    {   send("["$clMagenta$"~"$clReg$"] Last command was : "$lastcommand);
        return;
    }
    else if (Left(Line,9) ~= "PARTYLINE")
    {   GetPartyLine();
    }
    else if (Left(Line,11) ~= "ADMINLOGIN ")
    {   AdminLogin(Line);
    }
    else if (Left(Line,1) ~= "/")
    {   ConsoleCmd(Mid(Line,1));
    }
    else if (Left(Line,15) ~= "CONSOLECOMMAND ")
    {   ConsoleCmd(Mid(Line,15));
    }
    else if (Left(Line,3) ~= "WHO")
    {   Who();
    }
    else if (Left(Line,4) ~= "MSG ")
    {   SetMsg(Mid(Line,4));
    }
    else if (Left(Line,6) ~= "COLOR ")
    {   SetColor(Mid(Line,6));
    }
    else if (Left(Line,11) ~= "LISTPLAYERS")
    {   ListPlayers();
    }
    else if (Left(Line,11) ~= "LISTBOTS")
    {   ListBots();
    }
    else if (Left(Line,14) ~= "LISTSPECTATORS")
    {   ListSpectators();
    }
    else if (Left(Line,9) ~= "TESTCOLOR")
    {   TestColors();
    }
    else if (Left(Line,7) ~= "KICKID ")
    {   KickId(Mid(Line,7));
    }
    else if (Left(Line,5) ~= "KICK ")
    {   KickName(Mid(Line,5));
    }
    else if (Left(Line,6) ~= "BANID ")
    {   KickBanID(Mid(Line,6));
    }
    else if (Left(Line,4) ~= "BAN ")
    {   KickBanName(Mid(Line,4));
    }
    else if (Left(Line,10) ~= "KICKBANID ")
    {   KickBanID(Mid(Line,10));
    }
    else if (Left(Line,8) ~= "KICKBAN ")
    {   KickBanName(Mid(Line,8));
    }
    else if (Left(Line,13) ~= "LISTGAMETYPES")
    {   ListGameTypes();
    }
    else if (Left(Line,9) ~= "LISTMAPS ")
    {   ListMaps(Mid(Line,9));
    }
    else if (Left(Line,12) ~= "LISTMUTATORS")
    {   ListMutators();
    }
    else if (Left(Line,16) ~= "LISTUSEDMUTATORS")
    {   ListUsedMutators();
    }
    else if (Left(Line,14) ~= "SHUTDOWNSERVER")
    {   ShutDownServer(Mid(Line,15));
    }
    else if (Left(Line,15) ~= "VIEWPERMISSIONS")
    {   ViewPermissions();
    }
    else if (Left(Line,5) ~= "ABORT")
    {   Abort();
    }
    else if (Left(Line,5) ~= "PAUSE")
    {   PauseGame();
    }
    else if (Left(Line,7) ~= "MUTATE ")
    {   MutateCmd(Mid(Line,7));
    }
    else if (Left(Line,13) ~= "RESTARTSERVER")
    {   RestartServer(Mid(Line,14));
    }
    else if (Left(Line,11) ~= "ADDMUTATOR ")
    {   RestartServer(Mid(Line,11));
    }
    else if (Left(Line,14) ~= "REMOVEMUTATOR ")
    {   RestartServer(Mid(Line,14));
    }
    else if (Left(Line,10) ~= "CHANGEMAP ")
    {   ChangeMap(Mid(Line,10));
    }
    else if (Left(Line,15) ~= "CHANGEGAMETYPE ")
    {   ChangeGameType(Mid(Line,15));
    }
    else if (Left(Line,12) ~= "SETMESSAGES ")
    {   SetMessages(Mid(Line,12));
    }
    else if (Left(Line,12) ~= "VIEWMESSAGES")
    {   ViewMessages();
    }
    else if (Left(Line,8) ~= "ADDUSER ")
    {   AddUser(Mid(Line,8));
    }

    else 
    {   send("["$clRed$"E"$clReg$"] unknown query (? or HELP for help)");
        return;
    }
    lastcommand = line;
}

function ProcEXIT()
{   Close();   
}

function ProcINFO( string s )
{   send("["$clMagenta$"~"$clReg$"] INFO");
    send("["$clAqua$"N"$clReg$"] HOSTNAME "$Level.Game.GameReplicationInfo.ServerName);
    send("["$clAqua$"N"$clReg$"] HOSTPORT "$Level.Game.GetServerPort());
    send("["$clAqua$"N"$clReg$"] MAPTITLE "$Level.Title);
    send("["$clAqua$"N"$clReg$"] MAPNAME "$Left(string(Level), InStr(string(Level), ".")));
    send("["$clAqua$"N"$clReg$"] GAMETYPE "$GetItemName(string(Level.Game.Class)));
    send("["$clAqua$"N"$clReg$"] NUMPLAYERS "$Level.Game.NumPlayers);
    send("["$clAqua$"N"$clReg$"] MAXPLAYERS "$Level.Game.MaxPlayers);
    send("["$clAqua$"N"$clReg$"] GAMEMODE openplaying");
    send("["$clAqua$"N"$clReg$"] MINNETVER "$Level.MinNetVersion);
    if ( Level.Game.WorldLog != None && !Level.Game.WorldLog.bWorldBatcherError )
		send("["$clAqua$"N"$clReg$"] WORLDLOG true");
	else
		send("["$clAqua$"N"$clReg$"] WORLDLOG false");
}

function string GetPlayer( PlayerPawn P, int PlayerNum )
{
	local string SkinName, FaceName;

	send("["$clAqua$"N"$clReg$"] PLAYERNAME "$PlayerNum$" "$P.PlayerReplicationInfo.PlayerName);
	send("["$clAqua$"N"$clReg$"] PLAYERFRAGS "$PlayerNum$" "$int(P.PlayerReplicationInfo.Score));
	send("["$clAqua$"N"$clReg$"] PLAYERPING "$PlayerNum$" "$P.ConsoleCommand("GETPING"));
	send("["$clAqua$"N"$clReg$"] PLAYERTEAM "$PlayerNum$" "$P.PlayerReplicationInfo.Team);
    send("["$clAqua$"N"$clReg$"] PLAYERCLASS "$PlayerNum$" "$P.Menuname);

	if(P.Skin == None)
	{
		P.static.GetMultiSkin(P, SkinName, FaceName);
		send("["$clAqua$"N"$clReg$"] PLAYERSKIN "$PlayerNum$" "$SkinName);
		send("["$clAqua$"N"$clReg$"] PLAYERFACE "$PlayerNum$" "$FaceName);
	}
	else
	{
		send("["$clAqua$"N"$clReg$"] PLAYERSKIN "$PlayerNum$" "$string(P.Skin));
		send("["$clAqua$"N"$clReg$"] PLAYERFACE "$PlayerNum$" "$"None");
	}
	if( P.PlayerReplicationInfo.bIsABot )
		send("["$clAqua$"N"$clReg$"] PLAYERISBOT "$PlayerNum$" true");
    send("["$clAqua$"N"$clReg$"] PLAYERIP "$PlayerNum$" "$P.GetPlayerNetworkAddress());
}

function ProcPLAYER( string s )
{   
    local Pawn P;
    local int n;
    local int i;
    i = 0;
    n = int(Right(s,Len(s)-7));
    send("["$clMagenta$"~"$clReg$"] PLAYER "$n);
    for( P=Level.PawnList; P!=None; P=P.nextPawn )
		if( P.IsA('PlayerPawn') )
		{   if ((P.PlayerReplicationInfo.bIsSpectator == false) && (P.PlayerReplicationInfo.PlayerID == int(s)))
            {
                GetPlayer(PlayerPawn(P),i);
                return;
            }
		}
    send("["$clRed$"E"$clReg$"] Player does not exist");

}

function ProcRULES( string s )
{      
	local Mutator M;
	local string NextMutator, NextDesc;
	local string EnabledMutators;
	local int Num, i;

    send("["$clMagenta$"~"$clReg$"] RULES");

	EnabledMutators = "";
	for (M = Level.Game.BaseMutator.NextMutator; M != None; M = M.NextMutator)
	{
		Num = 0;
		NextMutator = "";
		GetNextIntDesc("Engine.Mutator", 0, NextMutator, NextDesc);
		while( (NextMutator != "") && (Num < 50) )
		{
			if(NextMutator ~= string(M.Class))
			{
				i = InStr(NextDesc, ",");
				if(i != -1)
					NextDesc = Left(NextDesc, i);

				if(EnabledMutators != "")
					EnabledMutators = EnabledMutators $ ", ";
				 EnabledMutators = EnabledMutators $ NextDesc;
				 break;
			}
			
			Num++;
			GetNextIntDesc("Engine.Mutator", Num, NextMutator, NextDesc);
		}
	}
	send("["$clAqua$"N"$clReg$"] MUTATORS "$EnabledMutators);
	send("["$clAqua$"N"$clReg$"] LISTENSERVER "$string(Level.NetMode==NM_ListenServer));
    send("["$clAqua$"N"$clReg$"] TIMELIMIT "$DeathMatchPlus(Level.Game).TimeLimit);
    if (TeamGamePlus(Level.Game) != None)
        send("["$clAqua$"N"$clReg$"] GOALTEAMSCORE "$int(TeamGamePlus(Level.Game).GoalTeamScore));
    send("["$clAqua$"N"$clReg$"] FRAGLIMIT "$DeathMatchPlus(Level.Game).FragLimit);
    send("["$clAqua$"N"$clReg$"] MINPLAYERS "$DeathMatchPlus(Level.Game).MinPlayers);
    send("["$clAqua$"N"$clReg$"] CHANGELEVELS "$DeathMatchPlus(Level.Game).bChangeLevels);  
    if (TeamGamePlus(Level.Game) != None)
    {   send("["$clAqua$"N"$clReg$"] MAXTEAMS "$TeamGamePlus(Level.Game).MaxTeams);
        send("["$clAqua$"N"$clReg$"] BALANCETEAMS "$TeamGamePlus(Level.Game).bBalanceTeams);
        send("["$clAqua$"N"$clReg$"] PLAYERBALANCETEAMS "$TeamGamePlus(Level.Game).bPlayersBalanceTeams);
        send("["$clAqua$"N"$clReg$"] FRIENDLYFIRE "$int(TeamGamePlus(Level.Game).FriendlyFireScale*100)$"%");
    }
    send("["$clAqua$"N"$clReg$"] TOURNAMENT "$DeathMatchPlus(Level.Game).bTournament);
    if(DeathMatchPlus(Level.Game).bMegaSpeed)
        send("["$clAqua$"N"$clReg$"] GAMESTYLE Turbo");
	else
	if(DeathMatchPlus(Level.Game).bHardcoreMode)
        send("["$clAqua$"N"$clReg$"] GAMESTYLE Hardcore");
	else
        send("["$clAqua$"N"$clReg$"] GAMESTYLE Classic");
    send("["$clAqua$"N"$clReg$"] BOTSKILLS "$class'ChallengeBotInfo'.default.Skills[DeathMatchPlus(Level.Game).Difficulty]);
    send("["$clAqua$"N"$clReg$"] ADMINNAME "$Level.Game.GameReplicationInfo.AdminName);
	send("["$clAqua$"N"$clReg$"] ADMINEMAIL "$Level.Game.GameReplicationInfo.AdminEmail);
}

function ProcBASIC( string s )
{   send("["$clMagenta$"~"$clReg$"] BASIC");
    send("["$clAqua$"N"$clReg$"] GAMENAME ut");
    send("["$clAqua$"N"$clReg$"] GAMEVER "$Level.EngineVersion);
    send("["$clAqua$"N"$clReg$"] MINNETVER "$Level.MinNetVersion);
    send("["$clAqua$"N"$clReg$"] LOCATION "$Level.Game.GameReplicationInfo.Region);
}

function ProcECHO( string s )
{   send("["$clPurple$"e"$clReg$"] "$Right(s,Len(s)-5));
}

function ProcSAY( string s )
{   
    if (!getPerm("m")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud say something on the server");
        return;
    }
    if (Spectator == None) return;
    Spectator.BroadcastMessage("[T] "$uname$": "$Right(s,Len(s)-4));
}

function ProcESAY( string s )
{   
    if (!getPerm("t")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud say something on the server");
        return;
    }
    if (Spectator == None) return;
    Spectator.BroadcastMessage(Right(s,Len(s)-5), true, 'Say');
}

function ProcTSAY( string s )
{   
    local Pawn P;
    if (Spectator == None) return;

	for( P=Level.PawnList; P!=None; P=P.nextPawn )
		if( P.IsA('TelnetSpectator') )
		{
			P.ClientMessage( "[T] "$uname$": "$Right(s,Len(s)-5), 'Partyline', false );
		}
}

function ProcNICK( string s )
{   
    local Pawn P;
    for( P=Level.PawnList; P!=None; P=P.nextPawn )
		if( P.IsA('PlayerPawn') )
		{   if (P.PlayerReplicationInfo.PlayerName == Right(s,Len(s)-5))
            {
                send("["$clRed$"E"$clReg$"] This name is already in use");
                return;
            }
		}

    uname = Right(s,Len(s)-5);
    Spectator.PlayerReplicationInfo.PlayerName = uname;
    send("["$clMagenta$"~"$clReg$"] Nickname changed to "$uname);
}

function string GetTeam( TeamInfo T, int TeamNum )
{
    send("["$clAqua$"N"$clReg$"] TEAMNAME "$TeamNum$" "$T.TeamName);
    send("["$clAqua$"N"$clReg$"] TEAMSCORE "$TeamNum$" "$T.Score);
    send("["$clAqua$"N"$clReg$"] TEAMSIZE "$TeamNum$" "$T.Size);
}

function ProcTEAM( string s )
{   
    send("["$clMagenta$"~"$clReg$"] TEAM "$s);
    if ((int(s) > 3) || (int(s) < 0)) 
    {   send("["$clRed$"E"$clReg$"] This team does not exist");
        return;
    }
    if (Level.Game.bTeamGame == false)
    {   send("["$clRed$"E"$clReg$"] This is not an team game");
        return;
    }   
    GetTeam(TeamGamePlus(Level.Game).Teams[int(s)], int(s));
}

function ProcCOUNT( string s )
{  
    local pawn P;
    local int i;

    send("["$clMagenta$"~"$clReg$"] COUNT teams and players");
    send("["$clAqua$"N"$clReg$"] PLAYERCOUNT "$Level.Game.NumPlayers);
    send("["$clAqua$"N"$clReg$"] TEAMCOUNT 4");

    i = 0;
    for( P=Level.PawnList; P!=None; P=P.nextPawn )
	    if( P.IsA('Spectator') )
		{   i++;
		}
    send("["$clAqua$"N"$clReg$"] SPECTATORCOUNT "$i);

    i = 0;
    for( P=Level.PawnList; P!=None; P=P.nextPawn )
	    if( P.IsA('TelnetSpectator') )
		{   i++;
		}
    send("["$clAqua$"N"$clReg$"] TELNETSPECTATORCOUNT "$i);
}

function string GetHelpText(string help)
{
    local int i;
    for (i = 0; i < defines.helpContentSize; i++)
    {
        if (help ~= Left(defines.helpContent[i],InStr(defines.helpContent[i],"=")))
        {   
            return Mid(defines.helpContent[i],InStr(defines.helpContent[i],"=")+1);
        }
    }
}

function ProcHELP( string s )
{   
    local string hint;
    local string s2;
    if (s == "")
    {
        send("["$clCyan$"H"$clReg$"] PROTOCOL_VERSION "$PROTOCOL_VERSION);
        send("["$clCyan$"H"$clReg$"] type 'HELP <command>' to get help on <command>");
    }
    else 
    {   
        s2 = s;
        if (s ~= "\\") s2 = "BackSlash";
        if (s ~= "\\\\") s2 = "BackSlashBackSlash";
        if (s ~= "/") s2 = "Slash";
        if (s ~= "QUIT") s2 = "Exit";
        if (s ~= "BYE") s2 = "Exit";
        if (s ~= "?") s2 = "Help";
        hint = GetHelpText(s2);
        if (hint != "")
        {   send("["$clCyan$"H"$clReg$"] HELP "$Caps(s)$" : "$hint);
        }
        else
        {   send("["$clRed$"E"$clReg$"] HELP there is no help available for "$Caps(s));
        }
    }
}

function GetLevelProperty( string Prop )
{
    send("["$clAqua$"N"$clReg$"] LEVELPROP "$Caps(Right(Prop,Len(Prop)-13))$" "$Level.GetPropertyText(Right(Prop,Len(Prop)-13)));
}

function GetGameProperty( string Prop )
{
	send("["$clAqua$"N"$clReg$"] GAMEPROP "$Caps(Right(Prop,Len(Prop)-12))$" "$Level.Game.GetPropertyText(Right(Prop,Len(Prop)-12)));
}

function string GetPlayerProperty( string Prop )
{
	local PlayerPawn P;
    local int i;
	foreach AllActors(class'PlayerPawn', P) 
    {
         i++;
         send("["$clAqua$"N"$clReg$"] PLAYERPROP "$Caps(Right(Prop,Len(Prop)-14))$" "$i$" "$P.GetPropertyText(Right(Prop,Len(Prop)-14)));
	}
}

function JoinPartyLine()
{   
    local Pawn P;
    if (Spectator == None) return;

	for( P=Level.PawnList; P!=None; P=P.nextPawn )
	    if( P.IsA('TelnetSpectator') )
		{
			P.ClientMessage( "[T] "$uname$"("$IpAddrToString(RemoteAddr)$") joined the party line", 'Event', false );
		}
}

function LeavePartyLine()
{   
    local Pawn P;
    if (Spectator == None) return;

	for( P=Level.PawnList; P!=None; P=P.nextPawn )
	    if( P.IsA('TelnetSpectator') )
		{
			P.ClientMessage( "[T] "$uname$"("$IpAddrToString(RemoteAddr)$") left the party line", 'Event', false );
		}
}

function GetPartyLine()
{   local Pawn P;
    local int i;
    
    send("["$clMagenta$"~"$clReg$"] PARTYLINE LIST");
    i = 0;
	for( P=Level.PawnList; P!=None; P=P.nextPawn )
		if( P.IsA('TelnetSpectator') )
		{ 
			send("["$clAqua$"N"$clReg$"] PARTYLINE "$i$" "$TelnetSpectator(P).ta.uname);
            i++;
		}
}

function Who()
{   local Pawn P;
    local int i;
    
    send("["$clMagenta$"~"$clReg$"] PARTYLINE WHO LIST");
    i = 0;
	for( P=Level.PawnList; P!=None; P=P.nextPawn )
		if( P.IsA('TelnetSpectator') )
		{ 
			send("["$clAqua$"N"$clReg$"] WHO "$TelnetSpectator(P).ta.uname$" "$IpAddrToString(TelnetSpectator(P).ta.RemoteAddr));
            i++;
		}
}

function bool GetName(string nm)
{   local int i;
    if (nm == "") return false;
    for (i = 0; i < 32; i++)
    {   if (Username[i] == nm) return true;
    }
    return false;
}

function bool GetPassword(string nm)
{   local int i;
    if (nm == "") return false;
    for (i = 0; i < 32; i++)
    {   if (Username[i] == uname)
        {   if (Password[i] == nm) 
            {   perms = Permissions[i];
                msgs = messages[i];
                id = i;
                return true;
            }
            else return false;
        }
    }
    return false;
}

function AdminLogin(string ln)
{
    if (!getPerm("a")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud the have admin rights in UT");
        return;
    }
    Level.Game.AdminLogin( Spectator, Right(ln,Len(ln)-11));
}

function ConsoleCmd(string cmd)
{   
    local string res;
    if (!getPerm("c")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud to perform console commands");
        return;
    }
    res = Spectator.ConsoleCommand(cmd);
    if (res != "") send("["$clGreen$"C"$clReg$"] "$res);
}

function SetMsg(string onoff)
{   local string onoff10;
    local string onofftype;
    local bool msgon;

    if (InStr(" ",onoff) > -1)
    {   onoff10 = Left(onoff,InStr(" ",onoff));
        onofftype = Mid(onoff,InStr(" ",onoff));
    }
    else 
    {   onoff10 = onoff;
        onofftype = "";
    }

    if (onoff10 ~= "on") msgon = true;
    if (onoff10 ~= "off") msgon = false;
    if (onoff10 ~= "1") msgon = true;
    if (onoff10 ~= "0") msgon = false;

    if (onofftype == "")
    {   
        Spectator.bClientMessages=msgon;
        Spectator.bTeamMessages=msgon;
        Spectator.bVoiceMessages=msgon;
        Spectator.bLocalizedMessages=msgon;
        if (msgon) send("["$clMagenta$"~"$clReg$"] All messages are now ON");
          else send("["$clMagenta$"~"$clReg$"] All messages are now OFF");
    }

    if (onofftype ~= "CLIENT")
    {   
        Spectator.bClientMessages=msgon;
        if (msgon) send("["$clMagenta$"~"$clReg$"] Client messages are now ON");
          else send("["$clMagenta$"~"$clReg$"] Client messages are now OFF");
    }

    if (onofftype ~= "TEAM")
    {   
        Spectator.bTeamMessages=msgon;
        if (msgon) send("["$clMagenta$"~"$clReg$"] Team messages are now ON");
          else send("["$clMagenta$"~"$clReg$"] Team messages are now OFF");
    }

    if (onofftype ~= "VOICE")
    {   
        Spectator.bVoiceMessages=msgon;
        if (msgon) send("["$clMagenta$"~"$clReg$"] Voice messages are now ON");
          else send("["$clMagenta$"~"$clReg$"] Voice messages are now OFF");
    }

    if (onofftype == "LOCALIZED")
    {   
        Spectator.bLocalizedMessages=msgon;
        if (msgon) send("["$clMagenta$"~"$clReg$"] Localized messages are now ON");
          else send("["$clMagenta$"~"$clReg$"] Localized messages are now OFF");
    }
}

function SetColor(string onoff)
{   if (onoff ~= "on") Setup(true);
    if (onoff ~= "off") Setup(false);
    if (onoff ~= "1") Setup(true);
    if (onoff ~= "0") Setup(false);
    if (Len(clRed) > 0)
    {   send("["$clMagenta$"~"$clReg$"] Colors are now ON");
    }
    else 
    {   send("["$clMagenta$"~"$clReg$"] Colors are now OFF");
    }
}

function ListPlayers()
{   local Pawn P;
    
    send("["$clMagenta$"~"$clReg$"] PLAYERLIST");
	for( P=Level.PawnList; P!=None; P=P.nextPawn )
		if( P.IsA('PlayerPawn') )
		{ 
			if ((P.PlayerReplicationInfo.bIsSpectator == false) && (NetConnection(PlayerPawn(P).Player) != None)) send("["$clAqua$"N"$clReg$"] PLAYERNAME "$P.PlayerReplicationInfo.PlayerName$" ID="$P.PlayerReplicationInfo.PlayerID);
		}
}

function ListBots()
{   local Pawn P;
    
    send("["$clMagenta$"~"$clReg$"] BOTLIST");
	for( P=Level.PawnList; P!=None; P=P.nextPawn )
		if( P.IsA('PlayerPawn') )
		{ 
			if ((P.PlayerReplicationInfo.bIsSpectator == false) && (P.PlayerReplicationInfo.bIsABot)) send("["$clAqua$"N"$clReg$"] BOTNAME "$P.PlayerReplicationInfo.PlayerName);
		}
}

function ListSpectators()
{   local Pawn P;
    
    send("["$clMagenta$"~"$clReg$"] SPECTATORLIST");
	for( P=Level.PawnList; P!=None; P=P.nextPawn )
		if( P.IsA('Spectator') )
		{ 
			if ((P.PlayerReplicationInfo.bIsSpectator) && (NetConnection(PlayerPawn(P).Player) != None)) send("["$clAqua$"N"$clReg$"] SPECTATORNAME "$P.PlayerReplicationInfo.PlayerName$" ID="$P.PlayerReplicationInfo.PlayerID);
		}
}

function KickID(string id)
{   
    local Pawn aPawn;

    if (!getPerm("t")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
        return;
    }
    
	for( aPawn=Level.PawnList; aPawn!=None; aPawn=aPawn.NextPawn )
		if
		(	aPawn.bIsPlayer
			&&	string(aPawn.PlayerReplicationInfo.PlayerID)~=id 
			&&	(PlayerPawn(aPawn)==None || NetConnection(PlayerPawn(aPawn).Player)!=None ) )
		{
            send("["$clMagenta$"~"$clReg$"] Player with ID: "$id$" ("$aPawn.PlayerReplicationInfo.PlayerName$") has been kicked");
			aPawn.Destroy();
			return;
		}
}

function KickName(string pname)
{   local Pawn aPawn;

    if (!getPerm("t")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
        return;
    }
    
	for( aPawn=Level.PawnList; aPawn!=None; aPawn=aPawn.NextPawn )
		if
		(	aPawn.bIsPlayer
			&&	aPawn.PlayerReplicationInfo.PlayerName~=pname 
			&&	(PlayerPawn(aPawn)==None || NetConnection(PlayerPawn(aPawn).Player)!=None ) )
		{
            send("["$clMagenta$"~"$clReg$"] Player with name: "$aPawn.PlayerReplicationInfo.PlayerName$" has been kicked");
			aPawn.Destroy();
			return;
		}
}

function KickBanID(string id)
{       local Pawn aPawn;
	local string IP;
	local int j;

    if (!getPerm("t")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
        return;
    }

	for( aPawn=Level.PawnList; aPawn!=None; aPawn=aPawn.NextPawn )
		if
		(	aPawn.bIsPlayer
			&&	string(aPawn.PlayerReplicationInfo.PlayerID)~=id
			&&	(PlayerPawn(aPawn)==None || NetConnection(PlayerPawn(aPawn).Player)!=None ) )
		{
			IP = PlayerPawn(aPawn).GetPlayerNetworkAddress();
			if(Level.Game.CheckIPPolicy(IP))
			{
				IP = Left(IP, InStr(IP, ":"));
				Log("Adding IP Ban for: "$IP);
				for(j=0;j<50;j++)
					if(Level.Game.IPPolicies[j] == "")
						break;
				if(j < 50)
					Level.Game.IPPolicies[j] = "DENY,"$IP;
				Level.Game.SaveConfig();
			}
            send("["$clMagenta$"~"$clReg$"] Player with ID:"$id$" ("$aPawn.PlayerReplicationInfo.PlayerName$") ["$IP$"] has been banned");
			aPawn.Destroy();
			return;
		}
}

function KickBanName(string pname)
{   
    local Pawn aPawn;
	local string IP;
	local int j;

    if (!getPerm("t")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
        return;
    }

	for( aPawn=Level.PawnList; aPawn!=None; aPawn=aPawn.NextPawn )
		if
		(	aPawn.bIsPlayer
			&&	aPawn.PlayerReplicationInfo.PlayerName~=pname 
			&&	(PlayerPawn(aPawn)==None || NetConnection(PlayerPawn(aPawn).Player)!=None ) )
		{
			IP = PlayerPawn(aPawn).GetPlayerNetworkAddress();
			if(Level.Game.CheckIPPolicy(IP))
			{
				IP = Left(IP, InStr(IP, ":"));
				Log("Adding IP Ban for: "$IP);
				for(j=0;j<50;j++)
					if(Level.Game.IPPolicies[j] == "")
						break;
				if(j < 50)
					Level.Game.IPPolicies[j] = "DENY,"$IP;
				Level.Game.SaveConfig();
			}
            send("["$clMagenta$"~"$clReg$"] Player with name: "$aPawn.PlayerReplicationInfo.PlayerName$" ["$IP$"] has been banned");
			aPawn.Destroy();
			return;
		}
}

function ListGametypes()
{   
    local class<GameInfo>	TempClass;
	local String 			NextGame;
	local int				i;

	TempClass = class'TournamentGameInfo';
	NextGame = Level.GetNextInt("TournamentGameInfo", 0); 
    send("["$clMagenta$"~"$clReg$"] GAMETYPES");
	while (NextGame != "")
	{
		TempClass = class<GameInfo>(DynamicLoadObject(NextGame, class'Class'));
		send("["$clAqua$"N"$clReg$"] GAMETYPE "$NextGame$" "$TempClass.Default.GameName);
		NextGame = Level.GetNextInt("TournamentGameInfo", ++i);
	}
}

// DM = DeathMatch : BotPack.DeathMatchPlus
// CTF = Capture The Flag : BotPack.CTFGame
// TDM = Team DeathMatch : BotPack.TeamGamePlus
// LMS = Last Man Standing : BotPack.LastManStanding
// DOM = Dommination : BotPack.Domination
// ASS = Assult : BotPack.Assault
function ListMaps(String GameType)
{
    local class<GameInfo>	GameClass;
	local string FirstMap, NextMap, TestMap, MapName;
    local int i;

    for (i = 0; i < defines.GameTypesSize; i++)
    {
        if (GameType ~= GetNameString(defines.GameTypes[i])) GameType = GetValueString(defines.GameTypes[i]);

    }

	GameClass = class<GameInfo>(DynamicLoadObject(GameType, class'Class'));
	
	if(GameClass.Default.MapPrefix == "")
		return;

    send("["$clMagenta$"~"$clReg$"] MAPLIST for "$GameType);
	FirstMap = Level.GetMapName(GameClass.Default.MapPrefix, "", 0);
	NextMap = FirstMap;
	while (!(FirstMap ~= TestMap) && FirstMap != "")
	{
		if(!(Left(NextMap, Len(NextMap) - 4) ~= (GameClass.Default.MapPrefix$"-tutorial")))
		{
			send("["$clAqua$"N"$clReg$"] MAP "$GameType$" "$NextMap);
		}
			
		NextMap = Level.GetMapName(GameClass.Default.MapPrefix, NextMap, 1);
		TestMap = NextMap;
	}
}

function ListMutators()
{   local int NumMutatorClasses;
	local string NextMutator, NextDesc;
	local Mutator M;

    send("["$clMagenta$"~"$clReg$"] MUTATORLIST");
	Level.GetNextIntDesc("Engine.Mutator", 0, NextMutator, NextDesc);
	while( (NextMutator != "") && (NumMutatorClasses < 50) )
	{
        send("["$clAqua$"N"$clReg$"] MUTATOR "$NextMutator);
		NumMutatorClasses++;
		Level.GetNextIntDesc("Engine.Mutator", NumMutatorClasses, NextMutator, NextDesc);
	}
}

function ListUsedMutators()
{
    local string NextMutator, NextDesc;
	local Mutator M;    

    send("["$clMagenta$"~"$clReg$"] USEDMUTATORLIST");
    for (M = Level.Game.BaseMutator.NextMutator; M != None; M = M.NextMutator) {
		send("["$clAqua$"N"$clReg$"] USEDMUTATOR "$M);
	}
}

function String UsedMutators()
{
	local String OutStr;
    local Mutator M;   

	M = Level.Game.BaseMutator.NextMutator;
    if (M == none) return "";
    OutStr = string(M.Class);
    if (M.NextMutator == none) return OutStr;
	for (M = M.NextMutator; M != None; M = M.NextMutator) 
    {
		OutStr = OutStr$","$string(M.Class);
	}	
	return OutStr;
}

function ChangeGameType(string gametype)
{   
    local string newtype;
    local int i;
    if (!getPerm("h")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
        return;
    }

    for (i = 0; i < defines.GameTypesSize; i++)
    {
        if (GameType ~= GetNameString(defines.GameTypes[i])) GameType = GetValueString(defines.GameTypes[i]);

    }

    newtype = Left(string(Level), InStr(string(Level), "."))$".unr"$"?game="$gametype$"?mutator="$UsedMutators();
    send("["$clAqua$"N"$clReg$"] CHANGEGAMETYPE "$gametype);
    Level.ServerTravel(newtype, false);
}

function ChangeMap(string map)
{   
    local string newmap;
    if (!getPerm("h")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
        return;
    }
    newmap = Left(map, InStr(map, "."))$".unr"$"?game="$Level.Game.Class$"?mutator="$UsedMutators();
    send("["$clAqua$"N"$clReg$"] CHANGEMAP "$map);
    Level.ServerTravel(newmap, false);    
}

function RestartServer(string params)
{   
    local string url;
    if (!getPerm("h")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
        return;
    }
    if (InStr(params," ") > -1)
    {
        ShutDownTime = int(Left(params,InStr(params," ")));
        ShutDownMsg = Mid(params,InStr(params," ")+1);
    }
    else
    {   ShutDownTime = int(params);
        ShutDownMsg = "The server will restart in a few seconds";
    }
    Spectator.BroadcastMessage("!! restart "$CAPS(ShutDownMsg)$" !!");
    Spectator.BroadcastMessage("!! "$ShutDownTime$" SECONDS LEFT !!");
    lastShutDownMsg = Level.TimeSeconds;
    ShutDownTime = Level.TimeSeconds+ShutDownTime;
    bShutDownTick = false;
    bRestartTick = true;
    rurl = Left(string(Level), InStr(string(Level), "."))$".unr"$"?game="$Level.Game.Class$"?mutator="$UsedMutators();
    send("["$clAqua$"N"$clReg$"] RESTART url="$rurl);
    Enable('Tick');
}

// 1st parm = delay
// 2nd parm (optional) = msg
function ShutdownServer(string params)
{    if (!getPerm("h")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
        return;
    }
    if (InStr(params," ") > -1)
    {
        ShutDownTime = int(Left(params,InStr(params," ")));
        ShutDownMsg = Mid(params,InStr(params," ")+1);
    }
    else
    {   ShutDownTime = int(params);
        ShutDownMsg = "The server will be shut down shortly";
    }
    Spectator.BroadcastMessage("!! "$CAPS(ShutDownMsg)$" !!");
    Spectator.BroadcastMessage("!! "$ShutDownTime$" SECONDS LEFT !!");
    lastShutDownMsg = Level.TimeSeconds;
    ShutDownTime = Level.TimeSeconds+ShutDownTime;
    bShutDownTick = true;
    Enable('Tick');
}

function PauseGame()
{    if (!getPerm("t")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
        return;
    }

    if(Level.Pauser=="")
    {   Level.Pauser=Spectator.PlayerReplicationInfo.PlayerName;
        send("["$clAqua$"N"$clReg$"] PAUSE game IS paused");
    }
    else
    {   Level.Pauser="";
        send("["$clAqua$"N"$clReg$"] PAUSE game is NOT paused");
    }
}

function MutateCmd(string cmd)
{    if (!getPerm("t")) 
    {   send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
        return;
    }
    Level.Game.BaseMutator.Mutate(cmd, Spectator);
}

event Tick(float DeltaTime)
{   
    if (bShutDownTick)
    {
        if (ShutDownTime <= Level.TimeSeconds)
        {   Log("[~] ShutDown by Telnet admin "$uname);
            Level.ConsoleCommand("exit");
        }
        else if (Level.TimeSeconds >= lastShutDownMsg+5)
        {   Spectator.BroadcastMessage("!! shutdown: "$ShutDownMsg$" !!");
            Spectator.BroadcastMessage("!! shutdown: "$int(ShutDownTime-Level.TimeSeconds)$" seconds left !!");
            lastShutDownMsg = Level.TimeSeconds;
        }
    }
    if (bRestartTick)
    {
        if (ShutDownTime <= Level.TimeSeconds)
        {   Log("[~] Restart by Telnet admin "$uname);
            Level.ServerTravel(rurl, false);
        }
        else if (Level.TimeSeconds >= lastShutDownMsg+5)
        {   Spectator.BroadcastMessage("!! restart: "$ShutDownMsg$" !!");
            Spectator.BroadcastMessage("!! restart: "$int(ShutDownTime-Level.TimeSeconds)$" seconds left !!");
            lastShutDownMsg = Level.TimeSeconds;
        }
    }
}

function ViewPermissions()
{   
    send("["$clAqua$"N"$clReg$"] PERMISSIONS "$perms);
}

function ViewMessages()
{   
    send("["$clAqua$"N"$clReg$"] MESSAGES "$msgs);
}

function Abort()
{   bShutDownTick = false;
    bRestartTick = false;
    Spectator.BroadcastMessage("!! server stop aborted !!");
    send("["$clMagenta$"~"$clReg$"] aborted");
}

function TestColors()
{   send("color check : "$clBlack$"clBlack "$clGray$"clGray "$clMaroon$"clMaroon "$clRed$"clRed "$clGreen$"clGreen "$clLime$"clLime "$clOlive$"clOlive "$clYellow$"clYello "$clReg);
    send("color check : "$clNavy$"clNavy "$clBlue$"clBlue "$clPurple$"clPurple "$clMagenta$"clMagenta "$clCyan$"clCyan "$clAqua$"clAqua "$clSilver$"clSilver "$clWhite$"clWhite "$clReg);
    send(Chr(27)$"\[4;31mUnderline"$clReg);
    send(Chr(27)$"\[5;31mBlink"$clReg);
    send(Chr(27)$"\[7;31mReverse"$clReg);
    send(Chr(27)$"\[0;31;44mBackground"$clReg);
}

// ------------------ this code is `borrowed` from MeltDown's Dynamic mutator --------------------
// you can find MeltDown at http://www.planetunreal.com/unrealtower
// I've modified a few things to work for the Telnet Admin

function bool MutatorIsLoaded(string MutatorName) {
  local Mutator mut;

  for(mut=Level.Game.BaseMutator; mut!=None; mut=mut.NextMutator)
    if(string(mut.Class)~=MutatorName) return true;

  return false;
}

function SwitchTo(string MutatorList) {
  local string NewURL;

  NewURL=GetURLMap()$"?Mutator="$MutatorList;
  Level.ConsoleCommand("switchlevel"@NewURL);
}

function class<Mutator> GetMutatorClass(string MutatorName) {
  local class<Mutator> MClass;

  MClass = class<Mutator>(DynamicLoadObject(MutatorName, class'Class'));
  if(MClass==None) 
    MClass=class<Mutator>(DynamicLoadObject(MutatorName$"."$MutatorName, class'Class'));

  return MClass;
}

function AddSingleMutator(string MutatorName) {
  local class<Mutator> MClass;
  local string NewURL;
  local Mutator NewMutator;

  if (!getPerm("h")) 
  {
    send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
    return;
  }

  MClass=GetMutatorClass(MutatorName);
  if(MClass!=None) {
    NewMutator=Spawn(MClass, Level.Game);
    Level.Game.BaseMutator.AddMutator(NewMutator);
    send("["$clAqua$"N"$clReg$"] ADDMUTATOR "$MutatorName);
    return;
  } else {
    send("["$clRed$"E"$clReg$"] Unable to load "$MutatorName);
    return;
  }
}

function RemoveSingleMutator(string MutatorName) {
  local Mutator mut, LastMut;
  local bool Success;
  local class<Mutator> MClass;

  if (!getPerm("h")) 
  {
    send("["$clRed$"E"$clReg$"] You are not alloud to perform this command");
    return;
  }

  MClass=GetMutatorClass(MutatorName);

  if(MClass==None || MClass==Class || MClass==Level.Game.BaseMutator.Class) {
    send("["$clRed$"E"$clReg$"] Can't remove "$MutatorName);
    return;
  }

  for(mut=Level.Game.BaseMutator; mut!=None; mut=mut.NextMutator) {

    if(mut.Class==MClass) {
      if(LastMut==None) Level.Game.BaseMutator=mut.NextMutator;
      else              LastMut.NextMutator=mut.NextMutator;
      mut.Destroy();
      Success=true;
    }

    LastMut=mut;
  }

  if(!Success)
    send("["$clRed$"E"$clReg$"] Unable to remove "$MutatorName);
    else send("["$clAqua$"N"$clReg$"] REMOVEMUTATOR "$MutatorName);

  return;
}

function string GetMutatorList() {
  local string Muts;
  local Mutator mut;

  Muts="";

  for(mut=Level.Game.BaseMutator; mut!=None; mut=mut.NextMutator) {
    if(mut!=Level.Game.BaseMutator) 
      Muts=Muts$","$string(mut.Class);
  }
  return Mid(Muts,1);
}

function setMessages(String modi)
{   
    msgs = modi;

    if (InStr("t",msgs) != -1) 
    {
        Spectator.bTeamMessages = true;
    }
    else {
        Spectator.bTeamMessages = false;
    }
    if (InStr("v",msgs) != -1) 
    {
        Spectator.bVoiceMessages = true;
    }
    else {
        Spectator.bVoiceMessages = false;
    }
    if (InStr("c",msgs) != -1) 
    {
        Spectator.bClientMessages = true;
    }
    else {
        Spectator.bClientMessages = false;
    }
    if (InStr("l",msgs) != -1) 
    {
        Spectator.bLocalizedMessages = true;
    }
    else {
        Spectator.bLocalizedMessages = false;
    }

    if (InStr("*",msgs) != -1) 
    {
        Spectator.bClientMessages = true;
        Spectator.bTeamMessages = true;
        Spectator.bVoiceMessages = true;
        Spectator.bLocalizedMessages = true;
    }
    messages[id] = msgs;
}

function AddUser(String params)
{
}

//------------------------------------------------------------------------------------

















defaultproperties
{
}