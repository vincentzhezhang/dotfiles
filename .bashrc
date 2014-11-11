case $- in
    *i*) ;;
      *) return;;
esac

# Load essential constants
if [ -f ~/.bash_constants ]; then
    . ~/.bash_constants
fi

export TERM="xterm-256color"
export EDITOR="vim"
export VISUAL="vim"

shopt -s checkwinsize
shopt -s histappend

HISTCONTROL=erasedups
HISTSIZE=3000
HISTFILESIZE=9999

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [[ $OSTYPE == darwin* ]]; then #OSX specific configuration
  export CLICOLOR=1
  export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
  alias ls='ls -Gp'
else
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

DECORATORS=(ps1 aliases functions)
for decorator in ${DECORATORS[@]}; do
  if [ -f ~/.bash_${decorator} ]; then
    . ~/.bash_${decorator}
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

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi


# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# nodejs
export PATH=$HOME/.npm/bin:$PATH
export NODE_PATH=$NODE_PATH:/home/vincent/.npm/lib/node_modules

# textlive
export PATH=/usr/local/texlive/2014/bin/x86_64-linux:$PATH

# Initialization for FDK command line tools.Mon Aug 11 16:45:11 2014
FDK_EXE="$HOME/tools/FDK/Tools/linux"
PATH=${PATH}:"$HOME/tools/FDK/Tools/linux"
export PATH
export FDK_EXE

# For princetion exercises
PATH=${PATH}:"/home/vincent/algs4/bin"
export PATH
export PATH=/usr/local/bin:$PATH

# Fortune shines over you
files=(/usr/share/cowsay/cows/*)
cowsay `fortune` | toilet -F gay -f term

# viiiiiiiiiiiiiiii
set -o vi
