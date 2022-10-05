amixer set 'Master' on
amixer set 'Master' 30%
xautolock -time 10 -locker slock &
natural-scrolling.sh &
#pgrep -x sxhkd > /dev/null || sxhkd &
pulseaudio --start &
dunst & # notification receiver
playerctld daemon
.scripts/dwmbar.sh &
exec dbus-launch --autolaunch=$(cat /var/lib/dbus/machine-id) dwm
