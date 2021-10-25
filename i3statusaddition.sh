#!/bin/sh
# shell script to prepend i3status with more stuff

i3status | while :
do
        read line
        echo "$(playerctl metadata -f '{{xesam:artist}} - {{xesam:title}}')  | $line" || exit 1
done
