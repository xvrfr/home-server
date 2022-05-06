#!/usr/bin/env bash
set -e

source <(curl -sL "https://github.com/xvrfr/home-server/raw/main/misc/colorizing/colorized_messaging.sh") en

# Set defaults
X11VNC_PASSWD_FILE="/etc/x11vnc.passwd"
#X11VNC_USER=x11vnc

X11VNC_XAUTH='$('
X11VNC_XAUTH+="xauth info 2>/dev/null | tac | xargs | grep -Po '^([^:]*:){5}[[:blank:]]+[^0]([^:]*:[[:blank:]])*\K.*'"
X11VNC_XAUTH+=' || '
X11VNC_XAUTH+='ls /var/run/xauth/{*} 2>/dev/null'
X11VNC_XAUTH+=' || '
X11VNC_XAUTH+='ls /var/run/sddm/{*} 2>/dev/null'
X11VNC_XAUTH+=' || '
X11VNC_XAUTH+='echo guess'
X11VNC_XAUTH+=' )'


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
ExecStartPre=/bin/sh -c "/bin/systemctl set-environment X11VNC_XAUTH=$X11VNC_XAUTH"
ExecStart=/usr/bin/x11vnc -display :0 -auth \$X11VNC_XAUTH -forever -loop -noxdamage -repeat -rfbauth $X11VNC_PASSWD_FILE -rfbport 5900 -shared

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



