#! /usr/bin/env bash
# TODO try .inputrc

# load bash related script modules
BASH_SCRIPTS=(constants ps1 aliases functions)

for s in "${BASH_SCRIPTS[@]}"; do
    [ -f ~/.bash_"${s}" ] && . ~/.bash_"${s}"
done

export TERM="screen-256color"

if [[ -x "$(command -v nvim)" ]]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
else
  export EDITOR="vim"
  export VISUAL="vim"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# we don't want any of the lines below appear in the history
set +o history

# handy injection before load the main script
[ -f ~/.bashrc.before ] && . ~/.bashrc.before

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

shopt -s checkwinsize # update window size after every command

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Use bash-completion, if available
if [[ $OSTYPE == darwin* ]]; then
    BCMP_PATH="$(brew --prefix)/etc/bash_completion"
else
    BCMP_PATH=/usr/share/bash-completion/bash_completion
fi
[ -f $BCMP_PATH ] && . $BCMP_PATH

# enable color support
if [ -x /usr/bin/dircolors ]; then
    if [[ -f ~/.dircolors ]]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
fi
unset color_prompt force_color_prompt

[ -f ~/.git-completion.bash ] && . ~/.git-completion.bash

# handy injection after load the main script
[ -f ~/.bashrc.after ] && . ~/.bashrc.after

# remove duplicates from $PATH
PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

# setup the amazing fzf fuzzy finder for bash
# NOTE: set -o vi has to be placed before fzf.bash in order to correctly setup key bindings
#   see: https://github.com/junegunn/fzf#key-bindings-for-command-line
set -o vi
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

# just for fun
random_splash

# SSH detection, courtesy https://unix.stackexchange.com/a/9607
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    export SESSION_TYPE=remote/ssh
else
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) export SESSION_TYPE=remote/ssh;;
    esac
fi

# TMUX reuse the same session unless sshed in or already in tmux
if [ -z $SESSION_TYPE ] && [ -x "$(command -v tmux)" ] && [ -z "$TMUX" ]; then
    tmux new -A -s "$HOSTNAME"
fi

# better keyboard repeat behavior
xset r rate 300 40

# history settings
shopt -s histappend # append instead of overwrite
shopt -s cmdhist    # force multi-line histories format in a single line
export HISTSIZE=9999
export HISTFILESIZE=9999
export HISTIGNORE=cd:mv:cp:ls:bg:fg:echo:exit:clear:vi:vim:nvim:history:type:man:rm:wget
export HISTCONTROL=ignoreboth:erasedups
unset HISTTIMEFORMAT
# turn history back on again
set -o history
