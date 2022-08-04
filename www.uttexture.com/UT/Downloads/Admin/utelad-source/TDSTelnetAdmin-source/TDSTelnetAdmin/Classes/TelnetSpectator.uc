class TelnetSpectator extends MessagingSpectator;

var bool bClientMessages; 
var bool bTeamMessages;
var bool bVoiceMessages;
var bool bLocalizedMessages;
var TelnetAccept ta;

function AddMessage(PlayerReplicationInfo PRI, String S, name Type)
{
	if (ta == None) return;
    //if (ta.msgon == false) return;

    if (PRI != None) 
    {	ta.send("["$ta.clBlue$"M"$ta.clReg$"] "$Type$" "$PRI.PlayerName$": "$S);
	}
	else ta.send("["$ta.clBlue$"M"$ta.clReg$"] "$Type$" "$S);
}

function ClientMessage( coerce string S, optional name Type, optional bool bBeep )
{
	if (bClientMessages)
		AddMessage(None, S, Type); 
}

function TeamMessage( PlayerReplicationInfo PRI, coerce string S, name Type, optional bool bBeep )
{
	if (bTeamMessages) // watch out... this spectator is team less, so won't capture team messages
		AddMessage(PRI, S, Type);
}

function ClientVoiceMessage(PlayerReplicationInfo Sender, PlayerReplicationInfo Recipient, name messagetype, byte messageID)
{
    local VoicePack V;

	if (bVoiceMessages) //you may want to change this
    {
		if ( (Sender == None) || (Sender.voicetype == None) || (Player.Console == None) )
		    return;
		
	    V = Spawn(Sender.voicetype, self);
	    if ( V != None )
		    V.ClientInitialize(Sender, Recipient, messagetype, messageID);
        
        AddMessage(Sender, "voice message #"$messageID, messagetype);  

    }
}

function ReceiveLocalizedMessage( class<LocalMessage> Message, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject )
{
	if (bLocalizedMessages)
		AddMessage(RelatedPRI_1, Message.static.GetString(Switch, RelatedPRI_1,RelatedPRI_2,OptionalObject), 'LocalizedMessage');
}

function setTA(TelnetAccept tac)
{   ta = tac;
    ta.send("["$ta.clMagenta$"~"$ta.clReg$"] spectator active");
}

defaultproperties
{
     bClientMessages=True   //which message types to process
     bTeamMessages=True
     bVoiceMessages=True
     bLocalizedMessages=True
}
