# Установка x11vnc с автозагрузкой


![Tested on Kubuntu 20.04 LTS][tested-01-shield] 

[tested-01-shield]: https://img.shields.io/badge/Tested_on-Kubuntu_20.04_LTS-blue.svg

---

<details><summary><b><i>Почему эта инструкция</i></b>
</summary><br />

Один из самых популярных VNC-серверов для Linux это `x11vnc`, являющийся проектом с открытым исходным кодом. Его особенность в том, что он позволяет подключиться к уже существующему сеансу X-сервера, что удобно не только для доступа с другого компьютера через интернет, но и для управления компьютером с помощью смартфона.

Однако, после установки `x11vnc` не запущен, запуск требует довольно длинного списка параметров, а после перезагрузки квест необходимо выполнить наново.

Энтузиасты давно начали публиковать свои решения в виде инструкций для установки и настройки автозагрузки `x11vnc`, но часто эти решения помогают лишь в простых ситуациях.

Например, чаще всего мне встречались инструкции, где для автозагрузки создаётся сервис для `x11vnc` в `systemd`. Такой сервис будет запущен от имени пользователя `root`, не найдёт файл `/root/.XAuthority` и VNC не будет доступен без туннелирования даже при отсутствии ключа `-localhost` при запуске `x11vnc`.

Вышеописанный и некоторые другие недостатки привели меня к мысли, что создание скрипта автонастройки, не подверженного обнаруженным мной недостаткам было бы неплохой идеей.
</details>

---

__Установка необходимых пакетов__
```Shell
sudo apt update -y && sudo apt upgrade -y && \
sudo apt install -y \
         net-tools \
         x11vnc \
         xserver-xorg-video-dummy ;
```
__Скрипт настройки и создания сервиса автозагрузки*__
```Shell
curl -sL "https://github.com/xvrfr/home-server/raw/main/x11vnc-setup/files/x11vnc_configurator.sh" | sudo ${0#-} /dev/stdin
```
___* Внимание!___ _В скрипте использованы следующие значения по умолчанию:_
- _Пароль для подключения:_ ___x11vnc___
- _Путь к файлу паролей VNC:_ ___/etc/x11vnc.passwd___

___Рекомендуется сразу после завершения скрипта изменить пароль для подключения командной___
```Shell
x11vnc -storepasswd /etc/x11vnc.passwd
```
___Настройка для туннельного подключения завершена!___

_Однако, если требуется возможность подключения без создания туннеля (небезопасно), например, для доступа только из собственной (доверенной) сети, то требуются некоторые изменения:_
```Shell
curl -sL "https://github.com/xvrfr/home-server/raw/main/x11vnc-setup/files/x11vnc_reconfigurator_from_any_ip_access.sh" | sudo ${0#-} /dev/stdin
```
<h6><details><summary>Альтернативный способ включения не-туннельного доступа
</summary>

```Shell
sudo sed -i -e "s,-repeat -localhost -rfbauth,-repeat -rfbauth,g" \
         /lib/systemd/system/x11vnc.service && \
sudo systemctl daemon-reload && \
sudo systemctl restart x11vnc.service
```
</details></h6>

---
__Полезные ссылки:__
- https://help.ubuntu.com/community/VNC/Servers
- https://docs.j7k6.org/x11vnc-debian-ubuntu-linux/
- https://c-nergy.be/blog/?p=12220






