
# Export variables
export PATH=$PATH:$HOME/.scripts:$HOME/.AppImages
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim
export R_EDITOR=rstudio
export TERM=xterm
export TERMINAL=$TERM
#export BROWSER="firefox --private-window"
export BROWSER="firefox"
export HISTCONTROL=ignoreboth

## Set some defaults for opening programs.
## Defined for usage in scripts.
export FILEMANAGER=nemo
export IMAGES=xviewer #sxiv
export MEDIA=mpv
export READER=zathura
export PASSWD="keepassxc"

## Set programs to lock computer.
#export LOCK=slock

## Define fzf commands
# export FZF_DEFAULT_COMMAND="fdfind --hidden --ignore-case --exclude '.mozilla' -E '.cache' -E '.local' -E '.git' . /bin /usr/bin/ $HOME"
