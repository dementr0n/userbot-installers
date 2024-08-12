#!/bin/bash

#Hikka autoinstallation script

if [ "$EUID" -ne 0 ];then
    echo "Please run this script as root user"
    exit 1
fi

clear

export HOME=/root

cd /root

apt update && apt upgrade -y && apt install python3 python3-pip git libcairo2 sudo -y

git clone https://github.com/hikariatama/Hikka && cd $HOME/Hikka

mv /usr/lib/python3.*/EXTERNALLY-MANAGED /usr/lib/python3.*/EXTERNALLY-MANAGED.old

cd $HOME/Hikka && pip3 install -r requirements.txt 

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
cd $HOME/Hikka
python3 -m hikka --root --no-web" > hikka.sh

cd /root/scripts && chmod +x hikka.sh
cd /etc/systemd/system && systemctl enable hikka.service

clear
cd $HOME/Hikka && python3 -m hikka --root --no-web 


