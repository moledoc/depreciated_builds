xrdb -merge $HOME/.Xresources; xrdb -load $HOME/.Xresources &
xsetroot -cursor_name left_ptr& # cursor
setxkbmap -option caps:swapescape
tint2 &
compton &
nitrogen --restore &
xbindkeys -p &
firefox &
exec openbox
