# ringbot v0.0.1
A rudimentary bashscript for PoP mining Ringcoin (RNG). Published to level the playing field...  
This is a pretty specific setup based on scrot, xdotool and a virtual desktop running i3.

![ringbot in action](https://github.com/eimernase/ringbot/blob/master/ringbot.gif)

# On Debian/Ubuntu
Get all the tools
```
sudo apt install tigervnc-standalone-server scrot xdotool i3 i3status suckless-tools
```

Setup VNC  (replace user with your username)  
```
sudo printf '#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexec i3' > /home/user/.vnc/xstartup && chmod 755 /home/user/.vnc/xstartup  
sudo printf 'geometry=1280x800\ndpi=96' > /home/user/.vnc/config  
vncserver  
xtigervncviewer -SecurityTypes VncAuth -passwd /home/user/.vnc/passwd :1
```

You should now have a new desktop running i3 with a resolution of 1280x800.  
Switch workspaces with cmd+number (i.e. ALT+5 switches to workspace 5 if cmd was set to ALT) and open up terminal windows with cmd+return.

Now open the PoP mining tab in your ring-qt wallet on workspace 2 then run ./ringbot.sh from a terminal window on workspace 1 and watch your bot banging away at the puzzles :)

*Donations (BTC)  
1NBxtNyrQJThZbHDudFDMGyfEUMW173pfg*

Need assistance? You can find me on https://discord.gg/VuvMxRf  
eimernase
