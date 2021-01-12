# Close bluetooth
sudo rfkill block bluetooth

# Set volume 0 first logged in
amixer set Master 0

# Source .zsh_env
[[ -f ~/.zsh_env ]] && . ~/.zsh_env

# Source .zshrc
[[ -f ~/.zshrc ]] && . ~/.zshrc

## Switch caps-lock and escape.
#setxkbmap -option caps:swapescape

# Run startx when logged into tty1
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

# nicer implementation to starting x
#[[ $(who | awk '{print $2}') == tty1 ]] && exec startx
