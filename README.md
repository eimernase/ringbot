# ringbot v0.0.1
A rudimentary bot for PoP mining Ringcoin (RNG).\n
This is a pretty specific setup based on scrot, xdotool and a virtual desktop running i3.

# On Debian/Ubuntu
Get needed software}\n
sudo apt install tigervnc-standalone-server scrot xdotool i3 i3status suckless-tools

Setup VNC  (replace user with your username)\n
sudo printf '#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexec i3' > /home/user/.vnc/xstartup && chmod 755 /home/user/.vnc/xstartup\n
sudo printf 'geometry=1280x800\ndpi=96' > /home/user/.vnc/config\n
vncserver\n
xtigervncviewer -SecurityTypes VncAuth -passwd /home/user/.vnc/passwd :1

You should now have a new desktop running i3 with a resolution of 1280x800.\n
Open the PoP mining tab in ring-qt wallet on workspace 2 then run ./ringbot.sh from a terminal on workspace 1. That's it!

Donations (BTC)\n
1NBxtNyrQJThZbHDudFDMGyfEUMW173pfg

Need help? Ask me on https://discord.gg/VuvMxRf \n
eimernase
