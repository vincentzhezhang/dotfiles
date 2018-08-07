#! /usr/bin/env bash
# TODO try .inputrc
# TODO extra platform specific settings to a separate script

# If not running interactively, don't do anything
# this is essential for login shell working correctly
case $- in
    *i*) ;;
      *) return;;
esac


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

#
# load bash related script modules
#
BASH_SCRIPTS=(\
  constants\
  utilities\
  aliases\
  ps1\
  )

for s in "${BASH_SCRIPTS[@]}"; do
  [ -f ~/.bash_"${s}" ] && . ~/.bash_"${s}"
done

# TODO double check if conditional TERM is still applicable
# if [ -n "$REMOTE_SESSION" ]; then
  # export TERM='xterm-256color'
# else
  # export TERM='screen-256color'
# fi
export TERM='xterm-256color'

# update window size after every command
shopt -s checkwinsize

shopt -s cdspell
shopt -s dirspell

#
# history settings
#
function join_by { local d=$1; shift; echo -n "$1"; shift; printf "%s" "${@/#/$d}"; }
hist_ignore=(
clear
exit
history
)

shopt -s cmdhist    # force multi-line histories format in a single line
shopt -s histappend
unset HISTTIMEFORMAT
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=9999       # maximum entries allowed in current history
HISTFILESIZE=9999   # maximum lines allowed in history file
HISTIGNORE="$(join_by '*:' "${hist_ignore[@]}")"
trap clean_up_history EXIT

#
# default editor
#
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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Use bash-completion, if available
if [[ "$(command -v bash)" =~ brew ]]; then
  BCMP_PATH="$(brew --prefix)/etc/bash_completion"
else
  BCMP_PATH=/usr/share/bash-completion/bash_completion
fi
[[ -f $BCMP_PATH ]] && . $BCMP_PATH

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

#
# fzf tweaks
#

# let __fzf_cd__ ignore node_modules and static directories
read -r -d '' FZF_ALT_C_COMMAND <<BASH
command find -L . -mindepth 1 \
  \\(\
    -path '*/\\.*' -o \
    -path '*/node_modules' -o \
    -path '*/static' -o \
    -fstype 'sysfs' -o \
    -fstype 'devfs' -o \
    -fstype 'devtmpfs' -o \
    -fstype 'proc' \
  \\) -prune -o -type d -print 2> /dev/null | cut -b3-
BASH
export FZF_ALT_C_COMMAND

# let __fzf_select__ ignore node_modules and static directories
read -r -d '' FZF_CTRL_T_COMMAND <<BASH
command find -L . -mindepth 1 \
  \\(\
      -path '*/\\.*' -o \
      -path '*/node_modules' -o \
      -path '*/static' -o \
      -fstype 'sysfs' -o \
      -fstype 'devfs' -o \
      -fstype 'devtmpfs' -o \
      -fstype 'proc' \
  \\) -prune -o \
  -type f -print -o \
  -type d -print -o \
  -type l -print 2> /dev/null | cut -b3-
BASH
export FZF_CTRL_T_COMMAND
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

# FIXME proper fix to eliminate the possibility of duplicates
# remove duplicates from $PATH
PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

# just for fun
random_splash

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
