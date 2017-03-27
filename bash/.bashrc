#! /usr/bin/env bash
# TODO try .inputrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
BASH_START=$(date +%s%3N)

# we don't want any of the lines below appear in the history
set +o history
# Record each line as it gets issued
# PROMPT_COMMAND='history -a'

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

#
# handy injection before load the main script
#
BASH_PREV=$(date +%s%3N)
[ -f ~/.bashrc.before ] && . ~/.bashrc.before
NOW=$(date +%s%3N)
echo "loaded .bashrc.before in $((NOW - BASH_PREV))ms"

export TERM="xterm-256color"
export EDITOR="vim"
export VISUAL="vim"

# Automatically trim long paths in the prompt
export PROMPT_DIRTRIM=3

# load bash related script modules
BASH_SCRIPTS=(constants ps1 aliases functions)

for s in "${BASH_SCRIPTS[@]}"; do
    BASH_PREV=$(date +%s%3N)
    [ -f ~/.bash_${s} ] && . ~/.bash_${s}
    NOW=$(date +%s%3N)
    echo "loaded .bash_${s} in $((NOW - BASH_PREV))ms"
done

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
BASH_PREV=$(date +%s%3N)
[ -f $BCMP_PATH ] && . $BCMP_PATH
NOW=$(date +%s%3N)
echo "loaded bash-autocomplete in $((NOW - BASH_PREV))ms"


# enable color support
if [ -x /usr/bin/dircolors ]; then
    if [[ -f ~/.dircolors ]]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
fi
unset color_prompt force_color_prompt

BASH_PREV=$(date +%s%3N)
[ -f ~/.git-completion.bash ] && . ~/.git-completion.bash
NOW=$(date +%s%3N)
echo "loaded git-autocomplete in $((NOW - BASH_PREV))ms"

# SSH auto completion
complete -W "$(grep --text '^ssh ' ~/.bash_history | sort -u | sed 's/^ssh //')" ssh

#
# handy injection after load the main script
#
BASH_PREV=$(date +%s%3N)
[ -f ~/.bashrc.after ] && . ~/.bashrc.after
NOW=$(date +%s%3N)
echo "loaded bashrc.after in $((NOW - BASH_PREV))ms"

# remove duplicates from $PATH
PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

# setup the amazing fzf fuzzy finder for bash
# NOTE: set -o vi has to be placed before fzf.bash in order to correctly setup key bindings
#   see: https://github.com/junegunn/fzf#key-bindings-for-command-line
BASH_PREV=$(date +%s%3N)
set -o vi
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
NOW=$(date +%s%3N)
echo "loaded fzf.bash in $((NOW - BASH_PREV))ms"

# history settings
shopt -s histappend # append instead of overwrite
shopt -s cmdhist    # force multi-line histories format in a single line
export HISTSIZE=1024
export HISTFILESIZE=1024
export HISTIGNORE='cd:ls:bg:fg:echo:exit:clear:vi:history:type'
export HISTCONTROL="ignoreboth:erasedups"

# just for fun
BASH_PREV=$(date +%s%3N)
random_splash
NOW=$(date +%s%3N)
echo "emit some bullshit in $((NOW - BASH_PREV))ms"

BASH_END=$(date +%s%3N)
echo "bash fully loaded in $((BASH_END - BASH_START))ms!"
# turn history back on again
time set -o history
