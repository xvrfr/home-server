#!/usr/bin/env bash
set -e


xauth list 

# Rename the existing .Xauthority file by running the following command
mv ~/.Xauthority ~/old.Xauthority 

# xauth with complain unless ~/.Xauthority exists
touch ~/.Xauthority

# only this one key is needed for X11 over SSH 
echo xauth gen
xauth generate :0 . trusted 

# generate our own key, xauth requires 128 bit hex encoding
echo xauth add
xauth add ${HOST}:0 . $(xxd -l 16 -p /dev/urandom)

# To view a listing of the .Xauthority file, enter the following 
echo xauth list
xauth list 

exit


# Set defaults
X11VNC_USER=x11vnc

id $X11VNC_USER || ( useradd $X11VNC_USER && ( echo "$X11VNC_USER:$X11VNC_USER" | chpasswd ))

# Creating service definition file for autostart on reboot
sudo cat > /lib/systemd/system/x11vnc.service << EOF
[Unit]
Description=Start x11vnc
After=multi-user.target

[Service]
User=$X11VNC_USER
Type=simple
ExecStart=/usr/bin/x11vnc -display :0 -auth guess -forever -loop -noxdamage -repeat -rfbauth /etc/x11vnc.passwd -rfbport 5900 -shared

[Install]
WantedBy=multi-user.target
EOF

# Re-starting service
systemctl daemon-reload
systemctl stop x11vnc.service
systemctl start x11vnc.service
