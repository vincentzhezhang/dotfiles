#! /usr/bin/env bash

# shellcheck disable=SC1090
# TODO try .inputrc
# TODO extra platform specific settings to a separate script

# If not running interactively, don't do anything, common non-interactive shells including:
# - login sheel
# - vi visual mode for long commands in shell
# - other app started shell
case $- in
  *i*) ;;
  *) return;;
esac

# handy box specific injection before we load the main part
[[ -f ~/.bashrc.before ]] && source ~/.bashrc.before

#
# load bash related script modules
#
BASH_SCRIPTS=(
  constants
  utilities
  aliases
  ps1
)

for s in "${BASH_SCRIPTS[@]}"; do
  [[ -f ~/.bash_"${s}" ]] && source ~/.bash_"${s}"
done

shopt -s cdspell
shopt -s checkwinsize # update window size after every command
shopt -s cmdhist      # force multi-line histories format in a single line
shopt -s dirspell
shopt -s extdebug
shopt -s histappend

#
# history settings
#
hist_ignore=(
  clear
  exit
  history
)

# also see history_magic in .bash_utilities
unset HISTTIMEFORMAT
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=9999       # maximum entries allowed in current history
HISTFILESIZE=9999   # maximum lines allowed in history file
HISTIGNORE="$(join_by '*:' "${hist_ignore[@]}")"

# if [[ -n $TMUX ]]; then
#   export TERM='tmux-256color'
# else
# fi
# FIXME tmux-256color don't play well with many apps, e.g. git, less
export TERM='xterm-256color'

# FIXME italics are still not working properly, sad
# export TERM_ITALICS=TRUE

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
[[ -x lesspipe ]] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

BCMP_PATH=/usr/share/bash-completion/bash_completion
[[ -f $BCMP_PATH ]] && source $BCMP_PATH
[[ -f ~/.git-completion.bash ]] && source ~/.git-completion.bash

# enable color support
if [[ -x dircolors ]]; then
  if [[ -f ~/.dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi
unset color_prompt force_color_prompt

# TODO
# - smart scope, e.g. use current directory or git root depends on the context
read -r -d '' GIT_DEFAULT_LS_COMMAND <<BASH
  git ls-files --cached --others --exclude-standard
BASH
export GIT_DEFAULT_LS_COMMAND

#
# fzf tweaks
#
read -r -d '' FZF_DEFAULT_COMMAND <<BASH
  ($GIT_DEFAULT_LS_COMMAND ||
   find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
      sed s/^..//) 2> /dev/null
BASH
export FZF_DEFAULT_COMMAND

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
  \\) -prune -o -type d -print 2> /dev/null | sed 's/^.\///'
BASH
export FZF_ALT_C_COMMAND

# let __fzf_select__ ignore node_modules and static directories
# TODO
# - determine symbolic link type and add trailing slash if applicable
read -r -d '' FZF_CTRL_T_COMMAND <<BASH
  ($GIT_DEFAULT_LS_COMMAND ||
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
      -type d -printf '%p/\n' -o \
      -type l -print \
  ) 2> /dev/null | sed 's/^.\///'
BASH
export FZF_CTRL_T_COMMAND

# FIXME decouple fzf with other bash scripts
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# handy box specific injection after we load the main part
[[ -f ~/.bashrc.after ]] && source ~/.bashrc.after

# FIXME proper fix to eliminate the possibility of duplicates
# remove duplicates from $PATH
PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

# just for fun
random_splash

# vim: set ai ts=2 sw=2 tw=79:
