# ringbot v0.0.1
A rudimentary bashscript for PoP mining Ringcoin (RNG). Published to level the playing field...  
Based on scrot, xdotool and a virtual desktop running i3.

![ringbot in action](https://github.com/eimernase/ringbot/blob/master/ringbot.gif)

# On Debian/Ubuntu
Get all the tools
```
sudo apt install tigervnc-standalone-server scrot xdotool i3 i3status suckless-tools git
git clone https://github.com/eimernase/ringbot
```
Setup VNC and connect to your own machine
```
sudo printf '#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexec i3' > /home/$USER/.vnc/xstartup && chmod 755 /home/$USER/.vnc/xstartup  
sudo printf 'geometry=1280x800\ndpi=96' > /home/$USER/.vnc/config  
vncserver  
xtigervncviewer -SecurityTypes VncAuth -passwd /home/$USER/.vnc/passwd :1
```
This should give you a new desktop running i3 with a resolution of 1280x800.  

You can switch workspaces with cmd+number (i.e. ALT+5 switches to workspace 5 if cmd was set to ALT) and open up terminal windows with cmd+return. To run programs with dmenu (i.e. ring-qt) press cmd+d and type in the name.

Now fire up the PoP mining tab in your ring-qt wallet on workspace 2 then run ./ringbot.sh from a terminal window on workspace 1 and watch your bot bang away at the puzzles :)

You can stop the script by switching back to workspace 1 and hitting CTRL+C.

Need assistance? You can find me on https://discord.gg/VuvMxRf  
eimernase

*Donations (RNG)  
RWJqQhFMNA8TKfjELdmkxR3kUu3Akg6KL7*

*Donations (BTC)  
1NBxtNyrQJThZbHDudFDMGyfEUMW173pfg*
