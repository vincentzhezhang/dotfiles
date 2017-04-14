#! /usr/bin/env bash
# handy ls aliases
alias ls='ls -CF --color=auto'
alias l='ls'
alias la='ls -A'
alias ll='ls -alh'
alias lt='ls -ltur'
alias lg='ll -A | grep -i'

# handy grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ag for better code search
alias ag='ag --color-match="1;31" --path-to-ignore ~/.agignore'
# TODO
# 1. batch search and replace
# 2. should add two versions, one is search recursively within current diretory
# 2. and the other search and replace, might including case options
# ag -l $1 | xargs sed -ri.bak -e "s/$1/$2/g"

alias mux="tmuxinator"

## Keeping things organized
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10'
alias cp='cp -i'
alias df='df -h'
alias du='du -h -c'
alias fsort='~/workspace/personal/auto_sorter/sort'
alias mkdir='mkdir -p -v'
alias mv='mv -i'
alias reload='source ~/.bashrc'

## Moving around & all that jazz
alias back='cd $OLDPWD'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

## Dir shortcuts
alias localhost='cd /var/www'

## App-specific
alias nano='nano -W -m'
alias ftp='ncftp Personal'
alias wget='wget -c'
alias scrot='scrot -c -d 7'

## Easy script callin'
alias show-info='~/.bin/info.pl'
alias show-colors='~/.bin/colors.sh'

## Misc
alias pg='ps aux | grep'

# some development quick n dirty shortcuts
alias cap='bundle exec cap'
alias rake='bundle exec rake'
alias pyserver='python -m SimpleHTTPServer'

# TODO
# fzf based command line app launcher
alias x='IFS=":"; for p in $PATH; do ls "$p" 2>/dev/null; done | fzf'

# NeoVim for the win
alias vi='nvim'
alias vim='nvim'

# use most recent version of git-cola
alias cola='git-cola'

# OS specific aliases
if [[ $OSTYPE == darwin* ]]; then
  # OSX specific aliases
  alias wtf='bbq'
else
  # Sudo fixes
  alias orphand='sudo deborphan | xargs sudo apt-get -y remove --purge'
  alias cleanup='sudo apt-get autoclean && sudo apt-get autoremove && sudo apt-get clean && sudo apt-get remove && orphand'
  alias updatedb='sudo updatedb'
  alias u='sudo apt update; sudo apt full-upgrade -y'

  # apt-get
  alias si='sudo apt-get install'
  alias sd='sudo apt-get update'

  # just fuck it
  alias fuck='sudo "$BASH" -c "$(history -p !!)"'
fi
