#! /usr/bin/env bash
# TODO move path to bashrc.before to decouple settings

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# we don't want any of the lines here appear in the history
set +o history

# handy before injection
[[ -f "$HOME/.bashrc.before" ]] && . "$HOME/.bashrc.before"

# history settings
HISTSIZE=4096
HISTFILESIZE=4096
HISTIGNORE='ls:bg:fg:history:type'
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
shopt -s cmdhist  # force multi-line history in one line
PROMPT_COMMAND="history -a"

# load my scripts
BASH_SCRIPTS=(constants ps1 aliases functions)

for s in "${BASH_SCRIPTS[@]}"; do
    [[ -f "$HOME/.bash_${s}" ]] && . "$HOME/.bash_${s}"
done

export TERM="xterm-256color"
export EDITOR="vim"
export VISUAL="vim"

# user bin
export PATH="$HOME/.local/bin:$PATH"

shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# OSX specific configuration
if [[ $OSTYPE == darwin* ]]; then
    if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
        . "$(brew --prefix)"/etc/bash_completion
    fi

    export CLICOLOR=1
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
    alias ls='ls -Gp'
else
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

    if [[ -f ~/.dircolors ]]
    then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
fi

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
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

complete -W "$(grep --text '^ssh ' "$HOME"/.bash_history | sort -u | sed 's/^ssh //')" ssh


# FIXME this seems problematic for some situation, needs verify
# reset term output status, execute before each command is executed
# trap 'tput sgr0' DEBUG

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# handy after injection
if [ -f "$HOME/.bashrc.after" ]; then
    . "$HOME/.bashrc.after"
fi

# remove duplicates from $PATH
PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

# just for fun
case $((RANDOM%4)) in
    0)
        bullshit
        ;;
    1)
        bulltruth
        ;;
    2)
        retrogame invaders
        ;;
    3)
        retrogame pacman
        ;;
esac

# viiiiiiiiiiiiiiii ftw
set -o vi

# turn history back on again
set -o history
