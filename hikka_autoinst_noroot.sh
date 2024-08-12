#!/bin/bash

#Hikka autoinstallation script

clear

sudo -S apt update && apt upgrade -y && apt install python3 python3-pip git libcairo2 sudo -y

git clone https://github.com/hikariatama/Hikka && cd $HOME/Hikka

sudo -S mv /usr/lib/python3.*/EXTERNALLY-MANAGED /usr/lib/python3.*/EXTERNALLY-MANAGED.old

cd $HOME/Hikka && pip3 install -r requirements.txt

sudo -S cd /etc/systemd/system && echo "[Unit]
Description = start hikka ub
[Service]
ExecStart = /root/scripts/hikka.sh

Restart=on-failure

RestartSec=5s

[Install]
WantedBy = multi-user.target" > hikka.service

sudo -S cd /root && mkdir scripts
sudo -S cd /root/scripts && echo "#!/bin/bash
cd /home/*/Hikka
python3 -m hikka --no-web" > hikka.sh

sudo -S cd /root/scripts && chmod +x hikka.sh
sudo -S cd /etc/systemd/system && systemctl enable hikka.service

clear
cd /root/Hikka && python3 -m hikka --no-web 
