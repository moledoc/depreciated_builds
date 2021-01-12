# Define config folder
#XDG_CONFIG_HOME="$HOME/.config"

# Export variables
export PATH=$PATH:$HOME/.scripts
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim
export TERM=xterm
export TERM_EXEC="$TERM -e" 
export TERMINAL=$TERM
export BROWSER="firefox --private-window"
#export PAGER=/usr/local/share/nvim/runtime/macros/less.sh
export HISTCONTROL=ignoreboth
# Set so bash uses only posix complient stuff.
#export POSIXLY_CORRECT=1

## Set some defaults for opening programs.
## Defined for usage in scripts.
export FILEMANAGER=pcmanfm
#export IMAGES=sxiv
export MEDIA=mpv
export READER=zathura

## Set programs to lock computer.
#export LOCK=slock

## Define fzf commands
#export FZF_DEFAULT_COMMAND='fd --hidden . $HOME'
