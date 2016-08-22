#! /usr/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# Load essential constants
if [ -f "$HOME/.bash_constants" ]; then
    . "$HOME/.bash_constants"
fi

export TERM="xterm-256color"
export EDITOR="vim"
export VISUAL="vim"

shopt -s checkwinsize

# history related settings
export HISTSIZE=999
export HISTFILESIZE=999
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
# NOTE: to avoid duplication on reload, reset PROMP_COMMAND here
export PROMPT_COMMAND='history -a'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#OSX specific configuration
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

DECORATORS=(ps1 aliases functions)
for decorator in "${DECORATORS[@]}"; do
    if [ -f ~/.bash_"${decorator}" ]; then
        . ~/.bash_"${decorator}"
    fi
done

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# nodejs
export PATH="$HOME/.node_modules_global/bin:$PATH"

# user bin
export PATH="$HOME/.local/bin:$PATH"

# go bin
export PATH=/usr/local/opt/go/libexec/bin:$PATH

# TODO: Move path settings to .bash_profile
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

complete -W "$(grep --text '^ssh ' "$HOME"/.bash_history | sort -u | sed 's/^ssh //')" ssh

# viiiiiiiiiiiiiiii ftw
set -o vi

# reset term output status, execute before each command is executed
trap 'tput sgr0' DEBUG

# turn on history
set -o history
