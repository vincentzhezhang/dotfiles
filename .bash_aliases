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

## Sudo fixes
alias orphand='sudo deborphan | xargs sudo apt-get -y remove --purge'
alias cleanup='sudo apt-get autoclean && sudo apt-get autoremove && sudo apt-get clean && sudo apt-get remove && orphand'
alias updatedb='sudo updatedb'

## Dev related
alias restart-apache='sudo /etc/init.d/apache2 restart'

## Misc
alias edit='vim'
alias pg='ps -ef | grep'
alias colour='/bin/bash ~/workspace/personal/dot_files/256_colors.sh'

## apt-get related
alias si='sudo apt-get install'
alias sd='sudo apt-get update'

# ssh connections
alias jss='ssh vincent@jinshisong.com'
alias yb='ssh vinnie@yongbet.com'
alias stg='ssh vincent@staging.jinshisong.com'
alias mt='ssh vincent@211.155.86.126'

# some development quick n dirty shortcuts
alias s='cd /home/vincent/workspace/jss/spree'
alias h='cd /home/vincent/workspace/jss/horsery'
alias ccache='/bin/rm -r /home/vincent/workspace/jss/spree/tmp/* /home/vincent/workspace/jss/spree/public/assets/*'
alias pryc='bundle exec pry -r ./config/environment'
alias rake='bundle exec rake'
alias r='rails r'
alias hs='python -m SimpleHTTPServer'
alias dbreload='rake db:drop db:create db:migrate'
alias sync_production='git co master; rake db:drop db:create; cap production db:sync_to_local'
alias sync_stating='git co master; rake db:drop db:create; cap staging db:sync_to_local'

alias vi='$(which vim)'
alias vim='$(which vim)'
