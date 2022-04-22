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
sudo x11vnc -storepasswd $X11VNC_PASSWD $X11VNC_PASSWD_FILE ;
chmod 0777 $X11VNC_PASSWD_FILE





# Cleanup
X11VNC_PASSWD=




