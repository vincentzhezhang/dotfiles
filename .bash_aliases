# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias lt='ll -t'
alias lg='ll -A | grep -i'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## Keeping things organized
alias rm='mv -t ~/.local/share/Trash/files'
alias prm='/bin/rm'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p -v'
alias df='df -h'
alias du='du -h -c'
alias reload='source ~/.bashrc'
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10'
alias fsort='~/workspace/personal/auto_sorter/sort'

## Moving around & all that jazz
alias back='cd $OLDPWD'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

## Dir shortcuts
alias home='cd ~/'
alias documents='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias books='cd ~/eBooks'
alias images='cd ~/pictures'
alias videos='cd ~/videos'
alias localhost='cd /var/www'
alias work='cd ~/workspace'

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
alias r='rails r'
alias hs='python -m SimpleHTTPServer'
alias dbreload='rake db:drop db:create db:migrate'
alias atrun='/home/vincent/workspace/foss/atom-shell-bin/atom'
