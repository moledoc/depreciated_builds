#!/bin/sh

xrdb -merge ~/.config/X/.Xresources
xrdb -load ~/.config/X/.Xresources
xsetroot -cursor_name left_ptr # change cursor
xset fp+ /usr/local/share/fonts/hermit;xset fp+ /usr/local/share/fonts/noto; xset fp+ /usr/local/share/fonts/Monoid
xset fp rehash
##xmodmap ~/.modmap &
setxkbmap -option caps:swapescape # swap esc and capslock
nitrogen --restore
sxhkd &
#panel &
bspwm -c $HOME/.config/bspwm/bspwmrc
