# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

set -o vi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# eval $(ssh-agent -s) > /dev/null;ssh-add ~/.ssh/git_key 2> /dev/null

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\n\[\033[34m\]\$\[\033[00m\] "

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# aliases

# apt
alias update="${ELEVATE} apt update;${ELEVATE} apt full-upgrade;alert"
alias install="${ELEVATE} apt install"
alias debinstall="${ELEVATE} dpkg -i"
alias dryinstall="${ELEVATE} apt install --dry-run"
alias uninstall="${ELEVATE} apt remove --auto-remove"
alias purge="${ELEVATE} apt purge"
alias autoremove="${ELEVATE} apt autoremove"
alias search="apt search"
alias show="apt show"
alias list="apt list"
alias installed="apt list --installed"
alias upgradable="apt list --upgradeable"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -1F --color=always'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=always -I --exclude=tags --exclude-dir=.git'
    alias fgrep='fgrep --color=always -I --exclude=tags --exclude-dir=.git'
    alias egrep='egrep --color=always -I --exclude=tags --exclude-dir=.git'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# movement/[cp|mv|rm]
alias b="cd .."
alias p="cd -"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -iv"

# directories
alias repo="cd $HOME/Documents/molecurrent"
alias dl="cd $HOME/Downloads"
alias doc="cd $HOME/Documents"
alias g="cd $HOME/go/src/github.com/moledoc"

# files
alias cfb="$EDITOR $HOME/.bashrc"
alias cfp="$EDITOR $HOME/.profile"
alias cfv="$EDITOR $HOME/.vimrc"
alias srcb="source $HOME/.bashrc"
alias srcp="source $HOME/.profile"
alias srcv="source $HOME/.vimrc"
alias todo="$EDITOR $HOME/todo"
alias rs="vim -S Session.vim"

# systemctl
alias sd="$ELEVATE systemctl poweroff"
alias po="$ELEVATE systemctl poweroff"
alias rb="$ELEVATE systemctl reboot"

# utilities
alias wget="wget --show-progress"

# git
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gl="git log"
alias gm="git merge"
alias gp="git push"
alias gpu="git pull"
alias gr="git reset"
alias gs="git status"
alias gbc="git branch --show-current"

# go
alias goi="go install"
alias gor="go run"
alias gob="go build"
alias goc="go clean"
alias got="go test -v -cover"
alias gobw="GOOS=windows GOARCH=amd64 go build"
alias gopt="cd ~/go;vim -c \"q\" test.go;exit"

# docker 
alias ds="$ELEVATE docker ps"
alias dr="$ELEVATE docker run"
alias dre="$ELEVATE docker restart"
alias dst="$ELEVATE docker stop"
alias drm="$ELEVATE docker rm"
