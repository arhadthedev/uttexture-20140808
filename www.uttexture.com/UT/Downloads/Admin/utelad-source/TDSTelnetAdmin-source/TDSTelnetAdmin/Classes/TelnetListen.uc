class TelnetListen expands TcpLink;

var globalconfig int TelnetPort;
var TelnetDefines defines;

function BeginPlay()
{
    Super.BeginPlay(); 
    Log("[~] launching TelnetAdmin on port "$TelnetPort);
    defines = spawn(class'TelnetDefines');
	BindPort(TelnetPort,true);
	Listen();
}

event GainedChild( Actor C )
{
	Super.GainedChild(C);
	if (C.IsA('TelnetAccept')) TelnetAccept(C).Listner = self;
}

defaultproperties
{
     AcceptClass=Class'TDSTelnetAdmin.TelnetAccept'
     TelnetPort=50023
}