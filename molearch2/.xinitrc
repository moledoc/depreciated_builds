#!/bin/sh

xrdb -merge ~/.config/X/.Xresources; xrdb -load ~/.config/X/.Xresources &
xsetroot -cursor_name left_ptr & # change cursor
##xmodmap ~/.modmap &
# setxkbmap -option caps:swapescape # swap esc and capslock # NOT NEEDED WITH PROGRAMMABLE KEYBOARD # -layout us,ee 
/usr/lib/notification-daemon-1.0/notification-daemon & # notification daemon
amixer set Master mute &
sxhkd &
exec bspwm -c $HOME/.config/bspwm/bspwmrc
