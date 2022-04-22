#!/usr/bin/env bash
set -e

# https://itsnotepad.ru/2020/11/13/x11vnc-avtozapusk-pri-starte-sistemy.html
# https://avg-it.ru/info/articles/nastroyka-udalyennogo-dostupa-do-kompyutera-s-linux-ubuntu-debian-mint-xubuntu-elementary-os/
# https://docs.j7k6.org/x11vnc-debian-ubuntu-linux/
# https://help.ubuntu.com/community/VNC/Servers


X11VNC_PASSWD_DEFAULT="/etc/x11vnc.passwd"

set_passwd ()
{
    X11VNC_PASSWD=$(sudo x11vnc -storepasswd $X11VNC_PASSWD_DEFAULT | awk -F': ' 'END{print$2}') ;
}

set_passwd ;



echo X11VNC_PASSWD=$X11VNC_PASSWD
