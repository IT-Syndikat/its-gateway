#!/bin/sh

write () {
    echo Write "$@" > /var/run/lcm/cmd
    sleep 0.1
}

clear () {
    echo Clear > /var/run/lcm/cmd
    echo Setpos 0 0 > /var/run/lcm/cmd
    sleep 0.1
}

res=$(/usr/local/bin/speedtest | grep load: | tr "\n" " ")
printf '%s %s\n' "$(date)" "$res" >> /home/speedtest/speedtest.txt

line=$(printf '%s' "$res"  | sed 's/^.*Download: \([0-9.]*\) Mbit\/s Upload: \([0-9.]*\).*$/DL: \1 Mbits\nUL: \2 Mbits/g')

(
    clear
    write $(printf '%s' "$line" | head -n1)
    echo Setpos 1 0 > /var/run/lcm/cmd
    sleep 0.1
    write $(printf '%s' "$line" | tail -n1)
)
