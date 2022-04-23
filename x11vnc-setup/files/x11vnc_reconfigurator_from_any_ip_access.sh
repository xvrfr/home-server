#!/usr/bin/env bash
set -e

function info { echo -e "\e[32m[info] $*\e[39m"; }

# Set defaults
X11VNC_XAUTH="$(ls /var/run/xauth/{*} 2>/dev/null || ls /var/run/sddm/{*} 2>/dev/null || echo guess )"
#X11VNC_USER=x11vnc

info "x11vnc will go with -auth ""$X11VNC_XAUTH"""

#id $X11VNC_USER || ( useradd $X11VNC_USER && ( echo "$X11VNC_USER:$X11VNC_USER" | chpasswd ))

# Creating service definition file for autostart on reboot
sudo cat > /lib/systemd/system/x11vnc.service << EOF
[Unit]
Description=Start x11vnc
After=multi-user.target

[Service]
#User=$X11VNC_USER
Type=simple
ExecStart=/usr/bin/x11vnc -display :0 -auth $X11VNC_XAUTH -forever -loop -noxdamage -repeat -rfbauth /etc/x11vnc.passwd -rfbport 5900 -shared

[Install]
WantedBy=multi-user.target
EOF

# Re-starting service
info "Restarting service"
systemctl daemon-reload
systemctl stop x11vnc.service
systemctl start x11vnc.service

info "Script completed."
exit 0



