#!/bin/bash
TRY=0
while [ "$DATA" == "" ] && [ $TRY -lt 5 ]; do
 DATA=$(python /home/pi/airthings/read_wave2.py 2950010920 0)
 TRY=$((TRY+1))
done
HUM=$(echo $DATA | awk '{print $2}')
TP=$(echo $DATA | awk '{print $5}')
RAD=$(echo $DATA | awk '{print $9}')
echo R=$RAD T=$TP H=$HUM
if [ "$RAD" != "" ]; then
 wget -O- "http://10.10.10.222:8080/json.htm?type=command&param=udevice&idx=74&nvalue=0&svalue=$RAD" >/dev/null 2>&1
fi
if [ "$TP" != "" ]; then
 wget -O- "http://10.10.10.222:8080/json.htm?type=command&param=udevice&idx=72&nvalue=0&svalue=$TP" >/dev/null 2>&1
fi
if [ "$HUM" != "" ]; then
 wget -O- "http://10.10.10.222:8080/json.htm?type=command&param=udevice&idx=73&nvalue=$HUM&svalue=1" >/dev/null 2>&1
fi
