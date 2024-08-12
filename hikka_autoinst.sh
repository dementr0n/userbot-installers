#!/bin/bash

#Hikka autoinstallation script

{if ! [ $(id -u) = 0 ]; then   echo "Start this from root user and from /root dir!"   exit 1 
fi
  }
apt update && apt upgrade -y && apt install python3 python3-pip git libcairo2 sudo -y

git clone https://github.com/hikariatama/Hikka && cd /root/Hikka

mv /usr/lib/python3.*/EXTERNALLY-MANAGED /usr/lib/python3.*/EXTERNALLY-MANAGED.old

pip3 install -r requirements.txt 

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
cd ~
cd Hikka
python3 -m hikka --root --no-web" > hikka.sh

cd /root/scripts && chmod +x hikka.sh
cd /etc/systemd/system && systemctl enable hikka.service

cd /root/Hikka && python3 -m hikka --root --no-web 


