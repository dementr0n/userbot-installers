#!/bin/bash

#Hikka autoinstallation script

if [ "$EUID" -ne 0 ];then
    echo "Please run this script as root user"
    exit 1
fi

clear

cd /root

apt update && apt upgrade -y && apt install python3 python3-pip git libcairo2 sudo -y

git clone https://github.com/hikariatama/Hikka && cd /root/Hikka

mv /usr/lib/python3.13/EXTERNALLY-MANAGED /usr/lib/python3.13/EXTERNALLY-MANAGED.old

mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.old

mv /usr/lib/python3.11/EXTERNALLY-MANAGED /usr/lib/python3.11/EXTERNALLY-MANAGED.old

cd /root/Hikka && pip3 install -r requirements.txt 

cd /etc/systemd/system && echo "[Unit]
Description = start hikka ub
[Service]
ExecStart = /root/scripts/hikka.sh

Restart=on-failure

RestartSec=5s

[Install]
WantedBy = multi-user.target" > hikka.service

cd /root && mkdir scripts
cd /root/scripts && echo "#!/bin/bash
cd /root/Hikka
python3 -m hikka --root --no-web" > hikka.sh

cd /root/scripts && chmod +x hikka.sh
cd /etc/systemd/system && systemctl enable hikka.service

clear
cd /root/Hikka && python3 -m hikka --root --no-web 


