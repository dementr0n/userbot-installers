#!/bin/bash

#sh1tn3t autoinstallation script

if [ "$EUID" -ne 0 ];then
    echo "Please run this script as root user"
    exit 1
fi

clear

cd /root

apt update && apt upgrade -y && apt install -y openssl git python3 python3-pip

git clone https://github.com/sh1tn3t/sh1t-ub && cd sh1t-ub

mv /usr/lib/python3.13/EXTERNALLY-MANAGED /usr/lib/python3.13/EXTERNALLY-MANAGED.old

mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.old

mv /usr/lib/python3.11/EXTERNALLY-MANAGED /usr/lib/python3.11/EXTERNALLY-MANAGED.old

pip3 install -r requirements.txt 

cd /etc/systemd/system && echo "[Unit]
Description = start shit ub
[Service]
ExecStart = /root/scripts/shit.sh

Restart=on-failure

RestartSec=5s

[Install]
WantedBy = multi-user.target" > shit.service

cd /root && mkdir scripts
cd /root/scripts && echo "#!/bin/bash
cd /root/sh1t-ub
python3 -m sh1t-ub" > shit.sh

cd /root/scripts && chmod +x shit.sh
cd /etc/systemd/system && systemctl enable shit.service

clear

cd /root/sh1t-ub && python3 -m sh1t-ub