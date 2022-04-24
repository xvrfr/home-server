# Installing x11vnc with starting on boot


![Tested on Kubuntu 20.04 LTS][tested-01-shield] 

[tested-01-shield]: https://img.shields.io/badge/Tested_on-Kubuntu_20.04_LTS-blue.svg

---

<details><summary><b><i>Why this manual</i></b>
</summary><br />

One of the most popular Linux VNC servers is `x11vnc`, which is an open source project. Its special feature is in allowing you to connect to an already existing X-server session. This is useful not only for accessing from another computer via the Internet, but also for controlling the machine using a smartphone.

However, after the installation finished, `x11vnc` is not started. It requires a quite long list of options to start, and after a reboot, the quest has to be passed again.

Enthusiasts have long ago begun to publish their solutions in the form of manuals for installing and configuring `x11vnc` startup, but these solutions often only help in simple situations.

E.g., the most often I came across manuals offering a service for `x11vnc` in `systemd` to be created for startup.  Such a service will run as `root`, will not find the `/root/.XAuthority` file, and VNC will not be available to connect without tunneling, even if the `-localhost` switch was not provided as an option for `x11vnc`.

The above and some other problems made me believe that it would be a good idea to create an configuring script that is not affected by those issues I found.

</details>

---

__Installing necessary packages__
```Shell
sudo apt update -y && sudo apt upgrade -y && \
sudo apt install -y \
         net-tools \
         x11vnc \
         xserver-xorg-video-dummy ;
```
__Script for configuring and making startup service*__
```Shell
curl -sL "https://github.com/xvrfr/home-server/raw/main/x11vnc-setup/files/x11vnc_configurator.sh" | sudo ${0#-} /dev/stdin
```
___* Warning!___ _Script uses the next defaults set:_
- _Connection password:_ ___x11vnc___
- _VNC password file location:_ ___/etc/x11vnc.passwd___

___It is strongly recommended to change the default connection password immediately after the script completed. Use:___
```Shell
x11vnc -storepasswd /etc/x11vnc.passwd
```
___The setup for a tunnelled connections, e.g., over SSH, is completed!___

_However, if you want to be able to connect without creating a tunnel (not secure), for example, to access only from your own (trusted) network, then some changes are required:_
```Shell
curl -sL "https://github.com/xvrfr/home-server/raw/main/x11vnc-setup/files/x11vnc_reconfigurator_from_any_ip_access.sh" | sudo ${0#-} /dev/stdin
```
<h6><details><summary>Alternative way to enable non-tunnel connections
</summary>

```Shell
sudo sed -i -e "s,-repeat -localhost -rfbauth,-repeat -rfbauth,g" \
         /lib/systemd/system/x11vnc.service && \
sudo systemctl daemon-reload && \
sudo systemctl restart x11vnc.service
```
</details></h6>

---
__Useful links:__
- https://help.ubuntu.com/community/VNC/Servers
- https://docs.j7k6.org/x11vnc-debian-ubuntu-linux/
- https://c-nergy.be/blog/?p=12220






