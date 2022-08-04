Mavericks IRC Reporter v1.14 by [Mv]DarkViper, www.mvreporter.de
----------------------------------------------------------------

The Mavericks Reporter is an UnrealTournament Server Actor, which connects to the IRC network, and posts message from the game into IRC.
This lets people follow any game without being on the server themselves.

Currently supported gametypes:

 - Deathmatch
 - 1on1
 - Team Deathmatch
 - Capture the Flag
 - Domination

Any other gametypes will be processed as "Deathmatch".


IMPORTANT:
----------

1. If you are already running a version of MvReporter and wish to update, please refer to the "Update-Section" below.
2. There is no UMOD version of MvReporter anymore since this led to confusion concerning the server-side installation.




1. Installation of the .zip file:
---------------------------------

The installation process is explained in the following steps: 

- Download the zip file into a temporary directory 
- Unzip the file into your UnrealTournament directory with full subdirectories (Upload to server)
- Open your server's .ini file (should be something like server.ini or unrealtournament.ini) in notepad 
- To enable the repoter you will have to add the following lines in the [Engine.GameEngine] section:

   [Engine.GameEngine]
   ServerActors=MvReporter.MvReporter


- Although the reporter would already function now, I recommend to set up the basic settings like irc server, channel and nickname.
  To do that simply copy the following text to the end of the .ini file you opened in notepad:

   [MvReporter.MvReporterConfig]
   bEnabled=True
   ServerAddr=irc.quakenet.org
   ServerPort=6667
   Channel=#mvrtest
   NickName=Mv|Reporter
   AdminPassword=admin

- You may change the settings in the part [MvReporter.MvReporterConfig] just as you wish (Server, Channel, Nick, etc)

- Now you MUST restart your Unreal Tournament server in order to enable the bot.



1.1 PSYBNC Support (IRC BOUNCER)
--------------------------------

From Version 1.14 on the bot supports bouncers to connect through. NOTE: This support is HIGHLY EXPERIMENTAL and is far from stable or final!

To setup bouncer support add (or modify if they exist) the following lines in your server's ini file:

   [MvReporter.MvReporterConfig]
   bUseLogin=True
   UserName=my_user_name_of_the_bnc
   Password=my_passwd_of_the_bnc


Alternatively you can setup bouncer support via the webadmin.



2. Installation of the Webadmin:
--------------------------------

Next we recommend to install the webadmin, so you can set up the rest (colors, etc) with a little more ease. To do that simply copy the following lines to the [UWeb.WebServer] part of your server's .ini file:

   [UWeb.WebServer]
   Applications[2]=MvReporter.MvReporterWeb
   ApplicationPaths[2]=/mvr
   Applications[3]=MvReporter.MvReporterImageServer
   ApplicationPaths[3]=/mvr_pic

Note: The numbers within the brackets may vary due to the number of webapplications already installed.
Now save the file and restart your UT server. The bot should now join the irc channel specified.
To configure it in more detail refer to the web admin.
You can call it in the /mvr directory on your server ip and the webadmin port in your web browser (e.g. http://213.23.42.52:80/mvr) 

Please use the following login data for the mvr webadmin:

Login   : mvr
Password: The adminpassword as specified above (refer to section 1. in the readme)



3. Update from previous version:
--------------------------------

If you installed the reporter already, you may want to update to version 1.14.
Please refer to the following steps to update properly:

- Download and unzip the zip file into a temporary directory
- Copy / upload all files into your UnrealTournament directory with full subdirectories.
  NOTE: You MUST overwrite ALL files in order to process the update correctly.
- Refer to the webadmin for any new features.

Note: All settings (like channel, nick, password) should have been remained from the previous installation.


---------------------------------------

Have fun. :)
For further information on available commands and other stuff don't forget to visit www.mvreporter.de

If you have any suggestions, bugs or anything else to report, feel free to visit our forums on www.mvclan.de/forum or write an email to darkviper@mvclan.de.