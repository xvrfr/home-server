# Headless VirtualBox (через RDP)

[![VirtualBox][virtualbox-shield]](https://www.virtualbox.org/)

![Supports multiarch Architecture][multiarch-shield] ![Supports amd64 Architecture][amd64-shield] ![Supports x86_64 Architecture][x86_64-shield] ![Supports i386 Architecture][i386-shield]


[multiarch-shield]: https://img.shields.io/badge/multiarch-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[x86_64-shield]: https://img.shields.io/badge/x86__64-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
[virtualbox-shield]: https://img.shields.io/badge/virtualbox-%23183A61.svg?&style=for-the-badge&logo=virtualbox&logoColor=white

English version is available [HERE: https://github.com/xvrfr/home-server/blob/main/virtualbox-headless/README.MD](https://github.com/xvrfr/home-server/blob/main/virtualbox-headless/README.MD)

---

<details><summary><b><i>Почему эта инструкция </i></b>
</summary><br />

VirtualBox (Oracle VM VirtualBox) — программный продукт виртуализации для операционных систем Windows, Linux, FreeBSD, macOS, Solaris/OpenSolaris, ReactOS, DOS и других.

Устанавливаемый поверх неё дополнительный пакет, обеспечивающий поддержку устройств USB 2.0 и 3.0, протокол удалённого рабочего стола (RDP), шифрование накопителя, загрузку с NVMe и по PXE, распространяется под особой лицензией PUEL («для личного использования и ознакомления»).

Для принятия лицензии, её текст будет выведен на экран во время установки, что не всегда приемлемо при выполнении скриптов автоматизации и установки на «безголовые» сервера.

Вышеописанное осложняется необходимостью повторять обновление дополнения при каждом обновлении самого VirtualBox.

</details>

---

__Установка необходимых пакетов__
```Shell
sudo apt update -y && sudo apt upgrade -y && \
sudo apt install -y \
         virtualbox ;
```
__Скрипт установки пакета дополнения с автоматическим принятием лицензии__
```Shell
curl -sL "https://github.com/xvrfr/home-server/raw/main/virtualbox-headless/files/virtualbox_extpack_installer.sh" | sudo ${0#-} /dev/stdin
```
___* Внимание!___ _Скрипт также изменяет следующие значения по умолчанию:_
- _Путь к папке-хранилищу виртуальных машин:_ ___/home/\_VirtualBox_VMs___

_При необходимости путь к папке-хранилищу виртуальных машин может быть изменён:_
```Shell
VBoxManage setproperty machinefolder /home/_VirtualBox_VMs
```

















