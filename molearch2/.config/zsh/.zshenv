# Export variables
export PATH=$PATH:$HOME/.scripts
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}

export EDITOR=nvim
export TERM=xterm
export TERM_EXEC="$TERM -e" 
export TERMINAL=$TERM
export BROWSER="devour firefox --private-window"
export PAGER="less --mouse" # add mouse support
export HISTCONTROL=ignoreboth

# Setting fd as the default source for fzf
# export FZF_DEFAULT_COMMAND='fd --hidden --type f . $HOME'
export FZF_DEFAULT_COMMAND='fd --hidden . $HOME'
# export FZF_DIR_COMMAND='fd --hidden --type d . $HOME'
# export FZF_FILE_COMMAND='fd --hidden --type f . $HOME'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="fd -t d . $HOME"

# check min/max brightness in the files located at
# /sys/class/power_supply/BAT0/
export min_brightness=0
export max_brightness=935
# check min/max volume with amixer range
# /sys/class/power_supply/BAT0/
export min_volume=0
export max_volume=87

# For panel pipe 
# (when used in scripts, the only one place to change variables)
export pipe_rs='rs'
export pipe_light='light'
export pipe_vol='vol'


## Set some defaults for opening programs.
## Defined for usage in scripts.
##export FILEMANAGER=nnn
export IMAGES='devour sxiv'
export MEDIA='mpv'
export READER='devour zathura'
export PASS='keepassxc'
export MESSENGER='devour signal-desktop'

## Set programs to lock computer.
#export LOCK=slock

#LSCOLORS='GbfxcxdxCxegedabcgacad'; export LSCOLORS
