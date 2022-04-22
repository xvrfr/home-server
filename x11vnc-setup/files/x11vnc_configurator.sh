#!/usr/bin/env bash
set -e

# https://itsnotepad.ru/2020/11/13/x11vnc-avtozapusk-pri-starte-sistemy.html
# https://avg-it.ru/info/articles/nastroyka-udalyennogo-dostupa-do-kompyutera-s-linux-ubuntu-debian-mint-xubuntu-elementary-os/
# https://docs.j7k6.org/x11vnc-debian-ubuntu-linux/
# https://help.ubuntu.com/community/VNC/Servers

# Set defaults
X11VNC_PASSWD_FILE="/etc/x11vnc.passwd"
X11VNC_PASSWD=x11vnc

# Creating password file
x11vnc -storepasswd $X11VNC_PASSWD $X11VNC_PASSWD_FILE ;
chmod 0777 $X11VNC_PASSWD_FILE

# Creating service definition file for autostart on reboot
cat > /lib/systemd/system/x11vnc.service << EOF
[Unit]
Description=Start x11vnc
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -display :0 -auth guess -forever -loop -noxdamage -repeat -localhost -rfbauth /etc/x11vnc.passwd -rfbport 5900 -shared

[Install]
WantedBy=multi-user.target
EOF

# Starting service
systemctl enable x11vnc.service
systemctl start x11vnc.service
systemctl daemon-reload

# Cleanup
X11VNC_PASSWD=




