#!/usr/bin/env bash
set -e


# Set defaults
X11VNC_USER=x11vnc

id $X11VNC_USER || adduser $X11VNC_USER --shell /sbin/nologin 

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
systemctl stop x11vnc.service
systemctl start x11vnc.service
systemctl daemon-reload

