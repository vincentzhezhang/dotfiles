#! /usr/bin/env bash
# TODO try .inputrc
# TODO extra platform specific settings to a separate script

BBQ="$([[ $- == *i* ]] && echo 'interactive' || echo 'non-interactive')"
BBQ="$BBQ $(shopt -q login_shell && echo 'login' || echo 'non-login')"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# handy injection before load the main script
[ -f ~/.bashrc.before ] && . ~/.bashrc.before

# common non-interactive shells including:
# - vi visual mode for long commands in shell
# - other app started shell

# SSH detection, courtesy https://unix.stackexchange.com/a/9607
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    REMOTE_SESSION=remote/ssh
else
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) REMOTE_SESSION=remote/ssh;;
    esac
fi

if [ -n "$REMOTE_SESSION" ]; then
  BBQ="$BBQ remote"
  export TERM='xterm-256color'
else
  export TERM='tmux-256color'
fi

# update window size after every command
shopt -s checkwinsize

# history settings
shopt -s histappend # append to HISTFILE Instead of overwrite
shopt -s cmdhist    # force multi-line histories format in a single line
unset HISTTIMEFORMAT
HISTSIZE=9999       # maximum entries allowed in current history
HISTFILESIZE=9999   # maximum lines allowed in history file
HISTIGNORE=cd:mv:cp:ls:bg:fg:echo:exit:clear:vi:vim:nvim:history:type:man:rm:wget
HISTCONTROL=ignoreboth:erasedups

# CAVEAT anything executed before interactive shell checking MUST has
# backwards compatibility with sh, otherwise the login shell will fail
if [ -x "$(command -v nvim)" ]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
else
  export EDITOR="vim"
  export VISUAL="vim"
fi

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
# set -o noclobber

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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x lesspipe ] && eval "$(lesspipe)"

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
if [ -x dircolors ]; then
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

echo -e "I am in a $BBQ shell"

# Automatic TMUX
# if [ -z "$REMOTE_SESSION" ] && [ -z "$TMUX" ] && [ -x "$(command -v tmux)" ]; then
#   # if a $HOSTNAME session exists, attach to it automatically
#   if tmux ls | grep -i "$HOSTNAME" > /dev/null 2>&1 ; then
#     tmux a -t "$HOSTNAME"
#   else
#     # Use tmuxinator if possible
#     if [ -x "$(command -v tmuxinator)" ]; then
#       tmuxinator "$HOSTNAME"
#     else
#       tmux new -A -s "$HOSTNAME"
#     fi
#     # reuse the same session
#   fi
# fi
# vim: set ai tw=79 sw=2:
