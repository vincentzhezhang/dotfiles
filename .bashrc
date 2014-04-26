[ -z "$PS1" ] && return

# Load essential constants
if [ -f ~/.bash_constants ]; then
    . ~/.bash_constants
fi

shopt -s checkwinsize

export TERM="xterm-256color"

shopt -s histappend
HISTCONTROL=ignoredups:erasedups:ignorespace:ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

export EDITOR="vim"
export VISUAL="vim"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    unset color_prompt
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

DECORATORS=(ps1 aliases functions)
#DECORATORS=(aliases functions)
for decorator in ${DECORATORS[@]}; do
  if [ -f ~/.bash_${decorator} ]; then
    . ~/.bash_${decorator}
  fi
done

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export PATH="~/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# For npm packages
export PATH=$HOME/.node/bin:$PATH
export NODE_PATH=$NODE_PATH:/home/vincent/.node/lib/node_modules

# Fortune shines over you
files=(/usr/share/cowsay/cows/*)
cowsay -f `echo ${files[$((RANDOM%${#files}))]}` `fortune` | toilet -F gay -f term

# Activate vi mode for bash
set -o vi

