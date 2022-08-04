BanHappy
Created by Mike "Mongo" Lambert, mongo@planetunreal.com
Modified by Michel "DarkByte" Comeau. darkbyte@prophetsofdeath.com

Installation:
--------------

Simply add the following line to your server's ini file which is usually named "unrealtournament.ini" (without the quotes).
This like should be in the [Engine.GameEngine] section of the file where all other similar lines are.

ServerActors=BanHappy.IPBanServer


That's all there is to it.


How it works:
----------------

BanHappy has its own ban list with 256 entries in it. These entries will start filling once the normal policies
get bigger than 45. It does the transfer when someone joins the game, and bans also at that time. I call
this late banning, since the person will have to download the files even if he's banned.

A new file named bans.ini with a section named [BanHappy.IPBanning] will be created and will contain the banned
ip's. You will have to check manually for duplicates and do the cleaning yourself.