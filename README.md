Пожалуйста, прочитайте инструкцию до конца!
Данный скрипт совместим с Debian, Ubuntu и на них основанных. 
Загрузите скрипт: 
curl -O https://raw.githubusercontent.com/dementr0n/Hikka-autoinst/master/hikka_autoinst.sh && chmod +x hikka_autoinst.sh && ./hikka_autoinst.sh
.После завершения работы скрипта вам необходимо загрузить модуль systemd (.dlm systemd), написать команды:
1: .addunit hikka
2: .units
3: Нажать на единственную кнопку hikka, и нажать Start для запуска юнита systemd.
4: Написать команду .terminal reboot
Скрипт конфигурирует systemd юнит, который автоматически запускает и перезапускает юзербота, системы с OpenRC(например Alpine)/SystemV(Devuan) НЕ ПОДДЕРЖИВАЮТСЯ!
Благодарности: https://github.com/hikariatama за юзербота Hikka.
О любых неполадках в работе скрипта сообщайте тут через Issues
P.S. Если вы хотите установить юзербота версии 1.6.4(Без надобности НЕ устанавливайте 1.6.4, она нестабильна и несет риск аккаунту), используйте команду:
.terminal git fetch && git checkout v1.6.4 && git pull
