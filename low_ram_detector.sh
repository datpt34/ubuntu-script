#!/bin/bash

#Minimum available memory limit, MB
THRESHOLD=300
THRESHOLD_KILL=100
#Check time interval, sec
INTERVAL=15
INTERVAL_NOTI=5

while :
do

    free=$(free -m|awk '/^Mem:/{print $4}')
    buffers=$(free -m|awk '/^Mem:/{print $6}')
    cached=$(free -m|awk '/^Mem:/{print $6}')
    available=$(free -m|awk '/^Mem:/{print $7}')

    message="Free $free""MB"", buffers $buffers""MB"", cached $cached""MB"", available $available""MB"""
    echo $message
    if [ $available -lt $THRESHOLD_KILL ]
        then
        pid=$(pidof chrome)
        kill $pid
        notify-send -u critical "Memory is running out!" "Kill chorme"
    fi
    if [ $available -lt $THRESHOLD ]
        then
        notify-send "Memory is running out!" "$message"
        sleep $INTERVAL_NOTI
        continue
    fi
    sleep $INTERVAL

done
