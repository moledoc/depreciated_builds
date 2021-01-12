# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/utt/.zshrc'

autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)

autoload -Uz promptinit
promptinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify
unsetopt beep
bindkey -v
export KEYTIMEOUT=1
# End of lines configured by zsh-newuser-install

##############
# Self defined

# Edit command in vim w/ ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Map moving in tab complete to vim keys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Read aliases from ~/.zsh_aliases and source plugins
source $HOME/.zsh_aliases
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh > /dev/null

# Can change prompt also with command
# prompt [option]
# see prompt -l
# the prompts are located in /usr/share/zsh/functions/Prompts.
# Also one can define ones own style
# For zsh the following link might help http://www.nparikh.org/unix/prompt.php#zsh

# NEEDS SOME CORRECTIONS STILL
#PS1="[`date +'%a %Y-%m-%d'` %B%T%b] %F{#FF0000}%U%2d%f%u %F{#555555}%K{#FF0000}%S `bspc query -D -n --names` %s%k%f < $(sh $HOME/.config/zsh/volume)|$(sh $HOME/.config/zsh/network)|$(sh $HOME/.config/zsh/battery)>
#%B%F{#FF0000}->%f%b "

PS1="
[%D{%Y-%m-%d} %B%T%b] %F{#FF0000}%U%2d%f%u 
%B%F{#FF0000}->%f%b "


PS2='%# '
PS3='%# '
PS4='%# '

# NNN setup
# Indicate depth level in nnn shell
[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"

# nnn cd on exit
# Use command n on commandline to have the cd on exit functionality.
# Using nnn opens nnn without cd on exit functionality.
n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
