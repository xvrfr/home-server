#!/usr/bin/env bash
set -e

function info { echo -e "\e[32m[info] $*\e[39m"; }
function warn  { echo -e "\e[33m[warn] $*\e[39m"; }

# Set defaults
X11VNC_PASSWD_FILE="/etc/x11vnc.passwd"
X11VNC_PASSWD=x11vnc

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

# Creating password file
warn "Using default password! To change password use:" 
warn " "
warn "    x11vnc -storepasswd $X11VNC_PASSWD_FILE"
warn " "
x11vnc -storepasswd $X11VNC_PASSWD $X11VNC_PASSWD_FILE ;
chmod 0777 $X11VNC_PASSWD_FILE

#info "Created password file: ""$X11VNC_PASSWD_FILE"""

# Creating service definition file for autostart on reboot
cat > /lib/systemd/system/x11vnc.service << EOF
[Unit]
Description=Start x11vnc
After=multi-user.target

[Service]
Type=simple
ExecStartPre=/bin/sh -c "/bin/systemctl set-environment X11VNC_XAUTH=$X11VNC_XAUTH"
ExecStart=/usr/bin/x11vnc -display :0 -auth \$X11VNC_XAUTH -forever -loop -noxdamage -repeat -localhost -rfbauth $X11VNC_PASSWD_FILE -rfbport 5900 -shared

[Install]
WantedBy=multi-user.target
EOF

info "Starting service"
# Starting service
systemctl enable x11vnc.service
systemctl start x11vnc.service
systemctl daemon-reload

# Cleanup
X11VNC_PASSWD=

info "Script completed."
exit 0




