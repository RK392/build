#!/bin/bash

sudo chown biqu:biqu /home/biqu/ -R
# sudo ntpdate stdtime.gov.hk

export AUDIODRIVER=alsa
export AUDIODEV=hw:0,0

cd /boot/gcode
if ls *.gcode > /dev/null 2>&1;then
    sudo cp ./*.gcode /home/biqu/printer_data/gcodes -fr
    sudo rm ./*.gcode -fr
fi
sync

cd /boot/scripts

./system_cfg.sh &

./connect_wifi.sh &

# regular sync to prevent data loss when direct power outage
./sync.sh &
