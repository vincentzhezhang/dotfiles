#! /usr/bin/env bash
shopt -s expand_aliases

#
# craps
#
alias weather='curl http://wttr.in/~shanghai,pudong,guozhan'

# you can never been too lazy
alias c='clear'

# handy ls aliases
alias ls='ls -CFh --color=auto' # h is not effective here but can be re-use by other aliases
alias sl='ls'
alias l='ls'
alias la='ls -A'
alias ll='ls -al'
alias lt='ls -ltur'
alias lg='ll -A | grep -i'
alias tree='tree -C'

# handy grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ag for better code search
alias ag='ag --color-match="1;31"'
# TODO
# 1. batch search and replace
# 2. should add two versions, one is search recursively within current diretory
# 2. and the other search and replace, might including case options
# ag -l $1 | xargs sed -ri.bak -e "s/$1/$2/g"

alias mux="tmuxinator"

alias vtop='vtop -t dark'

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
alias find_broken_symlink='find -L . -maxdepth 1 -type l'

# NeoVim for the win
alias vi='nvim'
alias vim='nvim'
alias emacs='nvim'
alias nano='nvim'

## App-specific
alias ftp='ncftp Personal'
alias wget='wget -c'
alias scrot='scrot -c -d 7'
alias tldr='tldr -t ocean'

## Easy script callin'
alias show-info='~/.bin/info.pl'
alias show-colors='~/.bin/colors.sh'

# some development quick n dirty shortcuts
alias cap='bundle exec cap'
alias rake='bundle exec rake'
alias pyserver='python -m SimpleHTTPServer'
alias ipython='ipython --colors=linux'
alias git-root='cd $(git rev-parse --show-toplevel)'

# TODO
# fzf based command line app launcher
alias x='$(IFS=":"; for p in $PATH; do command ls -1 "$p" 2>/dev/null; done | fzf --height=36%)'

# use most recent version of git-cola
alias cola='git-cola'
alias config_change='git --no-pager diff --no-color | xclip -sel clip | xclip -o -sel clip'

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
