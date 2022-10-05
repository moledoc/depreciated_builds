#!/bin/sh

while xsetroot -name " `echo $(cat /sys/class/power_supply/BAT0/capacity)%` `date \"+%a %F %R\"`"
do 
	sleep 60
done

# while xsetroot -name " `setxkbmap -query | grep --color=none "layout" | sed 's/layout:     //g'` `echo $(cat /sys/class/power_supply/BAT0/capacity)%` `date \"+%a %F %R\"`"
# do 
# 	test $(cat /sys/class/power_supply/BAT0/capacity) -le 20 && \
# 		test ! "$(cat /sys/class/power_supply/BAT0/status)" = "Charging" && \
# 		dunstify -a "battery" -u critical -h string:x-dunst-stack-tag:mybattery "Battery low"
# 	sleep 60
# done
