#!/usr/bin/env bash
set -e


# Set defaults
X11VNC_USER=x11vnc

id $X11VNC_USER || ( useradd $X11VNC_USER -s /sbin/nologin && ( echo "$X11VNC_USER:$X11VNC_USER" | chpasswd ))

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
