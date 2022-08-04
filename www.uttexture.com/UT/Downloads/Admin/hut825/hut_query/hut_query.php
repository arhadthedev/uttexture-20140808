<?
//=============================================================================
// Hez UT Version 8
// By Mickaël De 'HeZ' aka ATHoS ©2003-2005 hez-studios.net
//=============================================================================
// HUT QUERY, don't modify this part !!
error_reporting(E_ALL ^ E_NOTICE);
$addr = $_GET['addr'];
$port = $_GET['port'];
if( $addr == "" ){
	print "wrong command, usage: hut_query.php?addr=82.229.114.109&port=7777";
	return;
}
if ( $port < 1 )
	$port = 7777;
$info = @file_get_contents('http://'.$addr.':'.$port);
if( $info != "" ){
	for($i=0;$i<100;$i++){
		$j = substr($info,$k,3);
		$Line[$i] = substr($info,$k+3,$j);
		if( $Line[$i] == "" && $i > 4 )
			break; 	
		$k += (($j+3)+2); // +2 car len("\n") = 2
	}
	$Server_Name = array("ServerName","ServerPort","EngineVersion","GameClass","LevelTitle","Level",
						"NumPlayers","MaxPlayers","NumSpectators","MaxSpectators","Year","Month",
						"Day","Hour","Minute","AdminName","AdminEmail","bTeamGame","bGameEnded",
						"IsPassworded","ListenServer","TS_Red","TS_Blue","TS_Green","TS_Yellow",
						"ElapsedTime","TimeLimit","GameSpeed","bTournament","MinPlayers","FriendlyFire",
						"bBalanceTeams","GoalTeamScore","MaxTeams","HasBegun","HUTVersion");
	$Server_nb = 36;
	$Player_Name = array("PlayerName","PlayerID","Score","Deaths","Ping","Team", "Location","HasFlag",
						"bIsSpectator","bIsFemale","bIsABot","bFeigningDeath","bWaitingPlayer","bAdmin",
						"Time","TalkTexture","PlayerZone","VoiceType");
	$Player_nb = 18;
	$p = 0;
	for($z=0;$z<count($Line);$z++){
		$info = substr($Line[$z],2);
		$k = 0;
		switch( substr($Line[$z],0,2) ){
			case '01':
				for($i=0;$i<$Server_nb;$i++){
					$j = substr($info,$k,2);
					$Server[$Server_Name[$i]] = substr($info,$k+2,$j);
					$k += ($j+2);
				}
			break;
			case '02':
				for($i=0;$i<$Player_nb;$i++){
					$j = substr($info,$k,2);
					$Player[$p][$Player_Name[$i]] = substr($info,$k+2,$j);
					$k += ($j+2);
				}
				$p++;
			break;
			case '03':
				for($i=0;$i<16;$i++){
					$j = substr($info,$k,2);
					$Mutators[$i] = substr($info,$k+2,$j);
					if( $Mutators[$i] =="" )
						break;
					$k += ($j+2);
				}
			break;	
			case '04':
				$lines[$nl] = $info;
				$nl++;
			break;	
			default:break;
		}
	}
}
else{
	print'<table width="100%" bgcolor="#000000" align="center">
			<tr><td align="center"><font color="#990000">The server['.$addr.':'.$port.'] is unreachable.</font></td></tr>
		</table>';
	return;
}
//=============================================================================
// Hez UT Version 8
// By Mickaël De 'HeZ' aka ATHoS ©2003-2005 hez-studios.net
//=============================================================================
// HTML EXAMPLE, you can modify this part
/*
VALUES YOU CAN USE :
==================================
$Server["ServerName"]
$Server["ServerPort"]
$Server["EngineVersion"]
$Server["GameClass"]
$Server["LevelTitle"]
$Server["Level"]
$Server["NumPlayers"]
$Server["MaxPlayers"]
$Server["NumSpectators"]
$Server["MaxSpectators"]
$Server["Year"]
$Server["Month"]
$Server["Day"]
$Server["Hour"]
$Server["Minute"]
$Server["AdminName"]
$Server["AdminEmail"]
$Server["bTeamGame"]
$Server["bGameEnded"]
$Server["IsPassworded"]
$Server["ListenServer"]
$Server["TS_Red"]
$Server["TS_Blue"]
$Server["TS_Green"]
$Server["TS_Yellow"]
$Server["ElapsedTime"]
$Server["TimeLimit"]
$Server["GameSpeed"]
$Server["bTournament"]
$Server["MinPlayers"]
$Server["FriendlyFire"]
$Server["bBalanceTeams"]
$Server["GoalTeamScore"]
$Server["MaxTeams"]
$Server["HasBegun"]
$Server["HUTVersion"]

$Player[$i]["PlayerName"]
$Player[$i]["PlayerID"]
$Player[$i]["Score"]
$Player[$i]["Deaths"]
$Player[$i]["Ping"]
$Player[$i]["Team"]
$Player[$i]["Location"]
$Player[$i]["HasFlag"]
$Player[$i]["bIsSpectator"]
$Player[$i]["bIsFemale"]
$Player[$i]["bIsABot"]
$Player[$i]["bFeigningDeath"]
$Player[$i]["bWaitingPlayer"]
$Player[$i]["bAdmin"]
$Player[$i]["Time"]
$Player[$i]["TalkTexture"]
$Player[$i]["PlayerZone"]
$Player[$i]["VoiceType"]
($i : 0 to $p)
$p = number of players
$Mutators[$i]
($i : 0 to $m)
$m = number of mutators
==================================
*/
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>HeZ-UT Server Query</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="author" content="Mickael DEHEZ">
<meta name="generator" content="notepad">
<style type="text/css">
table{border-collapse: collapse;font: x-small Sylfaen;}
td {border: thin;font-family: Verdana;font-size: 11px;color: #FFFFFF;}
<!--  -->
a{color: #0606A3;text-decoration: none;font: bold}
a:hover {color: #FFCC00;text-decoration: none;font: bold}
BODY {
				font-family: Verdana;
				font-size: 10px;
				color: #FFFFFF;
				margin: 0;
}
</style>
<?
$i=0;
$Score = array($Server["TS_Red"],$Server["TS_Blue"],$Server["TS_Green"],$Server["TS_Yellow"]);
?>
</head>
<body bgcolor="gray">
<table style="border: thin" align="center">
	<tr>
		<td width="0" height="14" style="background: url(table/1.png)"></td>
		<td style="background: url(table/2.png)"><?=space1(10)?><font color="#000000" size="1"><b><?=$Server["ServerName"]?></b></font></td>
		<td width="0" style="background: url(table/3.png)"></td>
	</tr>
	<tr>
		<td style="background: url(table/8.png)"></td>
		<td>
			<table border="1" align="center" width="540" bgcolor="#000000" style="border: black">
				<tr>
					<td colspan="2" align="center">
						<hr>
						<b><?=$Server["ServerName"]?></b>
						<hr>
					</td>
				</tr>
				<tr>
					<td width="270">
						<ul>
							<li>Address : <?=$addr?>
							<li>Port : <?=$Server["ServerPort"]?>
							<li> <a href="unreal://<?=$addr.':'.$Server["ServerPort"]?>/">unreal://<?=$addr.':'.$Server["ServerPort"]?>/</a>
						</ul>
					</td>
					<td>
						<ul>
							<li>Versions : UT<?=$Server["EngineVersion"].' HuT'.$Server["HUTVersion"]?>
							<li>Admin : <?=$Server["AdminName"]?>
							<li>Email : <?=$Server["AdminEmail"]?>
						</ul>
					</td>
				</tr>
				<tr>
					<td width="270">
						<ul>
							<li>Game : <?=$Server["GameClass"]?>
							<li>Speed : <?=$Server["GameSpeed"]?>%
							<li>FriendlyFire : <?=$Server["FriendlyFire"]?>%
							<li>Min. Players : <?=$Server["MinPlayers"]?>
							<li>Passworded : <?=StateOnOff($Server["IsPassworded"])?>
							<li>Tournament : <?=StateOnOff($Server["bTournament"])?>
							<li>Mutators : 
							<ul>
								<?=DrawMutators($Mutators)?>
							</ul>
							<li>Map : <b><?=$Server["LevelTitle"]?></b>
							<li>Players : <font color="#006699"><b><?=$Server["NumPlayers"]?>/<?=$Server["MaxPlayers"]?></b></font>
							<li>Spectators : <?=$Server["NumSpectators"]?>/<?=$Server["MaxSpectators"]?>
							<li>Game State : <?=GameState($Server["HasBegun"],$Server["bGameEnded"])?>
							<li>Time : <?=DrawTime($Server["ElapsedTime"],$Server["TimeLimit"])?>
							<?if($Server["bTeamGame"]){?>
							<br>
								<li>GoalTeamScore : <?=$Server["GoalTeamScore"]?>
								<li>MaxTeams : <?=$Server["MaxTeams"]?>	
							<?}?>	
					</ul>
					</td>
					<td>
						<table border="1" bgcolor="#999999">
							<tr>
								<td><?=getMapSS($Server["Level"])?></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					<?=DrawPlayersList($Player,$Server["bTeamGame"],$Score)?>
					</td>
				</tr>
			</table>
		</td>
		<td style="background: url(table/4.png)"></td>
	</tr>
	<tr>
		<td height="14" style="background: url(table/7.png)"></td>
		<td style="background: url(table/6.png)"><?=space1(10)?><font color="#000000" size="1"><b>HUTv8 HTTP Server Query</b> :: <?=$Server["Year"]?>/<?=$Server["Month"]?>/<?=$Server["Day"]?> <?=$Server["Hour"]?>:<?=$Server["Minute"]?></font></td>
		<td style="background: url(table/5.png)"></td>
	</tr>
</table>
<?
function DrawTime($Time,$Limit){
	$m = floor($Time/60);
	$s = floor( ($Time/60 - floor($Time/60)) * 60 );
	if( strlen($m) < 2 )
		$m = '0'.$m;
	if( strlen($s) < 2 )
		$s = '0'.$s;
	if( !$Limit )
		return $m.':'.$s;
	if( strlen($Limit) < 2 )
		$Limit = '0'.$Limit;
	return $m.':'.$s.'/'.$Limit.':00';
}
function DrawMutators($Mutators){
	if( count($Mutators) < 1 )
		return 'empty<br>';
	for($i=0;$i<count($Mutators);$i++)
		$txt .= '<font color="#CCCC00">'.$Mutators[$i].'</font><br>';
	return $txt;
}
function GameState($bStartMatch,$bGameEnded){
	if($bGameEnded == 1)
		return '<font color="#CC0000">Game Ended</font>';
	if($bStartMatch != 1)
		return '<font color="#CC6600">Waiting Players</font>';
	return '<font color="#336600"><b>Playing</b></font>';
}
function StateOnOff($b){
	if($b)
		return '<font color="#006600"><b>ON</b></font>';
	return '<font color="#6699CC">OFF</font>';
}
function DrawPlayer($Player,$w){
	return '<table border="1" width="'.$w.'" bgcolor="#999999">
					<tr>
						<td rowspan="2" width="32" bgcolor="#000000" valign="bottom">'.DrawFace($Player["TalkTexture"]).'</td>
						<td style="color: '.GetColor($Player["Team"]).'"><b>'.space1(4).substr($Player["PlayerName"],0,16).'</b></td>
						<td width="16">'.DrawFlag($Player["HasFlag"]).'</td>
						<td width="50" style="font: xx-small;" rowspan="2" align="center">
							<font color="'.GetColor($Player["Team"]).'"><b>'.$Player["Score"].'</b></font>/'.$Player["Deaths"].'
							<br>Pi: '.$Player["Ping"].'
							<br>Ti: '.$Player["Time"].'
						</td>
					</tr>
					<tr>
						<td style="font: xx-small;" valign="top">'.space1(10).$Player["Location"].'</td>
						<td  width="16">'.bFeigningDeath($Player["bFeigningDeath"]).'</td>
					</tr>
				</table>';
}
function DrawPlayersList($Player,$bTeamGame,$Score){
	for($i=0;$Player[$i]["PlayerName"]!="";$i++){
		$j=0;
		$_team[$Player[$i]["Team"]]++;
		while( $Player[$i]["Score"]	< $_Player[$j]["Score"])
			$j++;
		for($k=count($_Player);$k>$j;$k--)
			 $_Player[$k] = $_Player[$k-1];
		$_Player[$j] = $Player[$i];
	}
	if(!$bTeamGame)
		for($k=0;$k<count($_Player);$k++)
			$txt .= DrawPlayer($_Player[$k],540);
	else{
		$l = 0;
		$w = 268;
		for($i=0;$i<4;$i++){
			if( $_team[$i] > 0 ){
				$_table[$l] .= DrawTeam($i,$Score[$i],$w);
				for($k=0;$k<count($_Player);$k++)
					if($_Player[$k]["Team"] == $i)
						$_table[$l].=DrawPlayer($_Player[$k],$w);
				$l++;
			}
		}
		if( $l > 0 ){
			$txt .= '<table width="540" style="border: thin" align="center">';
			$txt .= '<tr>
						<td width="'.$w.'" valign="top">'.$_table[0].'</td>
						<td width="'.$w.'" valign="top">'.$_table[1].'</td>
					</tr>';
			if( $l > 2 ) 
				$txt .= '<tr>
							<td valign="top">'.$_table[2].'</td>
							<td valign="top">'.$_table[3].'</td>
						</tr>';
		$txt .= '</table>';
		}	
	}
	return $txt;
}
function DrawTeam($i,$Score,$w){
	$Score = str_replace("00","0",$Score);
	$Score = str_replace("00","0",$Score);
	return '<table border="1" width="'.$w.'" bgcolor="'.GetColor($i).'">
					<tr>
						<td align="center">'.space1(10).GetTeamName($i).'</td>
						<td align="center" width="50"><b>'.space1(10).$Score.'</b></td>
					</tr>
				</table>';
}

function GetTeamName($k){
	switch($k){
		case 0:return "Red Team";
		case 1:return "Blue Team";
		case 2:return "Green Team";
		case 3:return "Yellow Team";
		default:return "Team";
	}
}
function DrawFlag($k){
	if($k)
		return '<img src="flags/1.gif" width="16" height="16" border="0" alt="1.gif" align="absmiddle" vspace="0" hspace="0">';
	return "";
}
function GetColor($k){
	switch($k){
		case 0:return "#990000";
		case 1:return "#000099";
		case 2:return "#003300";
		case 3:return "#996600";
		default:return "#FFFFCC";
	}
}
function DrawFace($s){
	$s = 'faces/'.substr($s,strpos($s,'.')+1).'.png';
	if( is_file($s) )
		return '<img src="'.$s.'" width="32" height="32" border="0" alt="'.$s.'" align="absbottom" vspace="0" hspace="0">';
	return "";
}
function bFeigningDeath($k){
	if($k)
		return "FD";
	return "";
}
function GetMapSS($s){
	$s = 'maps/'.$s.'.jpg';
	if( is_file($s) )
		return '<img src="'.$s.'" width="264" height="250" border="1" align="absmiddle" vspace="0" hspace="0">';
	return '<img src="pix.gif" width="264" height="250" border="1" align="absmiddle" vspace="0" hspace="0">';
}
function space1($i){
	return '<img src="pix.gif" width="'.$i.'" height="1" border="0" align="absmiddle">';
}
?>
</body>
</html>
