#! /usr/bin/env bash
# TODO try .inputrc
# TODO extra platform specific settings to a separate script

[[ $- == *i* ]] && echo 'Interactive' || echo 'Not interactive'
shopt -q login_shell && echo 'Login shell' || echo 'Not login shell'

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# common non-interactive shells including:
# - vi visual mode for long commands in shell
# - other app started shell

export TERM="tmux-256color"

# history settings
shopt -s histappend # append to HISTFILE Instead of overwrite
shopt -s cmdhist    # force multi-line histories format in a single line
unset HISTTIMEFORMAT
HISTSIZE=9999       # maximum entries allowed in current history
HISTFILESIZE=9999   # maximum lines allowed in history file
HISTIGNORE=cd:mv:cp:ls:bg:fg:echo:exit:clear:vi:vim:nvim:history:type:man:rm:wget
HISTCONTROL=ignoreboth:erasedups

# CAVEAT anything executed before interative shell checking MUST has
# backwards compatibility with sh, otherwise the login shell will fail
if [ -x "$(command -v nvim)" ]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
else
  export EDITOR="vim"
  export VISUAL="vim"
fi

# better consistent keyboard repeat behavior
KB_DELAY=240
KB_RATE=40
xset r rate $KB_DELAY $KB_RATE

# update window size after every command
shopt -s checkwinsize

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# NOTE: set -o vi has to be placed before fzf.bash in order to correctly setup key bindings
#   see: https://github.com/junegunn/fzf#key-bindings-for-command-line
set -o vi

# load bash related script modules
BASH_SCRIPTS=(\
  constants\
  utilities\
  functions\
  aliases\
  ps1\
  )

for s in "${BASH_SCRIPTS[@]}"; do
  [ -f ~/.bash_"${s}" ] && . ~/.bash_"${s}"
done

# handy injection before load the main script
[ -f ~/.bashrc.before ] && . ~/.bashrc.before

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
  if [ -f ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi
unset color_prompt force_color_prompt

[ -f ~/.git-completion.bash ] && . ~/.git-completion.bash

# handy injection after load the main script
[ -f ~/.bashrc.after ] && . ~/.bashrc.after

# setup the amazing fzf fuzzy finder for bash
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

# remove duplicates from $PATH
PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

# just for fun
random_splash

# SSH detection, courtesy https://unix.stackexchange.com/a/9607
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    export REMOTE_SESSION=remote/ssh
else
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) export REMOTE_SESSION=remote/ssh;;
    esac
fi

# Automatic TMUX
if [ -z "$REMOTE_SESSION" ] && [ -z "$TMUX" ] && [ -x "$(command -v tmux)" ]; then
  if tmux ls > /dev/null 2>&1 ; then
    tmux a
  else
    # Use tmuxinator if possible when there is no existing tmux session
    if [ -x "$(command -v tmuxinator)" ]; then
      tmuxinator "$HOSTNAME"
    else
      tmux new -A -s "$HOSTNAME"
    fi
    # reuse the same session
  fi
fi
