# some more ls aliases
alias l='ls -CF'
alias la='ls -A'
alias lg='ll -A | grep -i'
alias ll='ls -alFh'
alias lt='ll -t'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## Keeping things organized
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10'
alias cp='cp -i'
alias df='df -h'
alias du='du -h -c'
alias fsort='~/workspace/personal/auto_sorter/sort'
alias mkdir='mkdir -p -v'
alias mv='mv -i'
alias prm='/bin/rm'
alias reload='source ~/.bashrc'
alias rm='mv -t ~/.local/share/Trash/files'

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
alias pg='ps -ef | grep'

# some development quick n dirty shortcuts
alias cap='bundle exec cap'
alias rake='bundle exec rake'
alias pyserver='python -m SimpleHTTPServer'

alias vi='vim'


# OSX specific aliases
if [[ $OSTYPE == darwin* ]]; then
  alias gvim='mvim'

else
  # Sudo fixes
  alias orphand='sudo deborphan | xargs sudo apt-get -y remove --purge'
  alias cleanup='sudo apt-get autoclean && sudo apt-get autoremove && sudo apt-get clean && sudo apt-get remove && orphand'
  alias updatedb='sudo updatedb'

  # apt-get
  alias si='sudo apt-get install'
  alias sd='sudo apt-get update'

  # just fuck it
  alias fuck='sudo "$BASH" -c "$(history -p !!)"'
fi

