#! /usr/bin/env bash
#
# easy extract
#
extract () {
  if [ -f "$1" ] ; then
      case "$1" in
          *.tar.bz2)   tar xvjf "$1"    ;;
          *.tar.gz)    tar xvzf "$1"    ;;
          *.bz2)       bunzip2 "$1"     ;;
          *.rar)       rar x "$1"       ;;
          *.gz)        gunzip "$1"      ;;
          *.tar)       tar xvf "$1"     ;;
          *.tbz2)      tar xvjf "$1"    ;;
          *.tgz)       tar xvzf "$1"    ;;
          *.zip)       unzip "$1"       ;;
          *.Z)         uncompress "$1"  ;;
          *.7z)        7z x "$1"        ;;
          *)           echo "don't know how to extract $1..." ;;
      esac
  else
      echo "$1 is not a valid file!"
  fi
}

# makes directory then moves into it
function mkcdr {
    mkdir -p -v "$1"
    cd "$1" || return
}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

#netinfo - shows network information for your system
netinfo ()
{
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
/sbin/ifconfig | awk /'Bcast/ {print $3}'
/sbin/ifconfig | awk /'inet addr/ {print $4}'
/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
myip="$(lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g')"
echo "${myip}"
echo "---------------------------------------------------"
}

# dirsize - finds directory sizes and lists them for the current directory
dirsize ()
{
du -shx ./* .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
egrep '^ *[0-9.]*M' /tmp/list
egrep '^ *[0-9.]*G' /tmp/list
rm -rf /tmp/list
}

# cleanof - clean files older than specific days
cleanof ()
{
  find . -mtime +"$1" -print0 | xargs /bin/rm -Rf
}

# smart pwd
function smart_pwd {
    local pwdmaxlen=25
    local trunc_symbol=".."
    local dir=${PWD##*/}
    local tmp=""
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        tmp=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        tmp=${trunc_symbol}/${tmp#*/}
        if [ "${#tmp}" -lt "${#NEW_PWD}" ]; then
            NEW_PWD=$tmp
        fi
    fi
}

#
# just for fun
#
# shellcheck disable=SC2154
retrogame ()
{
    # assign all the variants of foreground and background colors to local
    # variable for later use, note the value of f, b are expanded within
    # substitution with exclamation mark.
    # the code below dynamically assign color code 30..47 to f0..f7 and b0..b7
    # respectively
    # shellcheck disable=SC2034
    f=3
    # shellcheck disable=SC2034
    b=4
    for j in 'f' 'b'; do
        for i in {0..7}; do
            printf -v "$j$i" %b "\e[${!j}${i}m"
        done
    done
    bld=$'\e[1m'
    rst=$'\e[0m'

    case $1 in
        invaders)

cat <<-EOF
${f1}  ▀▄   ▄▀     ${f2} ▄▄▄████▄▄▄    ${f3}  ▄██▄     ${f4}  ▀▄   ▄▀     ${f5} ▄▄▄████▄▄▄    ${f6}  ▄██▄  $rst
${f1} ▄█▀███▀█▄    ${f2}███▀▀██▀▀███   ${f3}▄█▀██▀█▄   ${f4} ▄█▀███▀█▄    ${f5}███▀▀██▀▀███   ${f6}▄█▀██▀█▄$rst
${f1}█▀███████▀█   ${f2}▀▀███▀▀███▀▀   ${f3}▀█▀██▀█▀   ${f4}█▀███████▀█   ${f5}▀▀███▀▀███▀▀   ${f6}▀█▀██▀█▀$rst
${f1}▀ ▀▄▄ ▄▄▀ ▀   ${f2} ▀█▄ ▀▀ ▄█▀    ${f3}▀▄    ▄▀   ${f4}▀ ▀▄▄ ▄▄▀ ▀   ${f5} ▀█▄ ▀▀ ▄█▀    ${f6}▀▄    ▄▀$rst

$bld${f1}▄ ▀▄   ▄▀ ▄   ${f2} ▄▄▄████▄▄▄    ${f3}  ▄██▄     ${f4}▄ ▀▄   ▄▀ ▄   ${f5} ▄▄▄████▄▄▄    ${f6}  ▄██▄  $rst
$bld${f1}█▄█▀███▀█▄█   ${f2}███▀▀██▀▀███   ${f3}▄█▀██▀█▄   ${f4}█▄█▀███▀█▄█   ${f5}███▀▀██▀▀███   ${f6}▄█▀██▀█▄$rst
$bld${f1}▀█████████▀   ${f2}▀▀▀██▀▀██▀▀▀   ${f3}▀▀█▀▀█▀▀   ${f4}▀█████████▀   ${f5}▀▀▀██▀▀██▀▀▀   ${f6}▀▀█▀▀█▀▀$rst
$bld${f1} ▄▀     ▀▄    ${f2}▄▄▀▀ ▀▀ ▀▀▄▄   ${f3}▄▀▄▀▀▄▀▄   ${f4} ▄▀     ▀▄    ${f5}▄▄▀▀ ▀▀ ▀▀▄▄   ${f6}▄▀▄▀▀▄▀▄$rst


                                      ${f7}▌$rst

                                    ${f7}▌$rst

                             ${f7}    ▄█▄    $rst
                             ${f7}▄█████████▄$rst
                             ${f7}▀▀▀▀▀▀▀▀▀▀▀$rst
EOF
        ;;

        pacman)
cat <<-EOF
${f3}  ▄███████▄   ${f1}  ▄██████▄    ${f2}  ▄██████▄    ${f4}  ▄██████▄    ${f5}  ▄██████▄    ${f6}  ▄██████▄
${f3}▄█████████▀▀  ${f1}▄${f7}█▀█${f1}██${f7}█▀█${f1}██▄  ${f2}▄${f7}█▀█${f2}██${f7}█▀█${f2}██▄  ${f4}▄${f7}█▀█${f4}██${f7}█▀█${f4}██▄  ${f5}▄${f7}█▀█${f5}██${f7}█▀█${f5}██▄  ${f6}▄${f7}█▀█${f6}██${f7}█▀█${f6}██▄
${f3}███████▀      ${f1}█${f7}▄▄█${f1}██${f7}▄▄█${f1}███  ${f2}█${f7}▄▄█${f2}██${f7}▄▄█${f2}███  ${f4}█${f7}▄▄█${f4}██${f7}▄▄█${f4}███  ${f5}█${f7}▄▄█${f5}██${f7}▄▄█${f5}███  ${f6}█${f7}▄▄█${f6}██${f7}▄▄█${f6}███
${f3}███████▄      ${f1}████████████  ${f2}████████████  ${f4}████████████  ${f5}████████████  ${f6}████████████
${f3}▀█████████▄▄  ${f1}██▀██▀▀██▀██  ${f2}██▀██▀▀██▀██  ${f4}██▀██▀▀██▀██  ${f5}██▀██▀▀██▀██  ${f6}██▀██▀▀██▀██
${f3}  ▀███████▀   ${f1}▀   ▀  ▀   ▀  ${f2}▀   ▀  ▀   ▀  ${f4}▀   ▀  ▀   ▀  ${f5}▀   ▀  ▀   ▀  ${f6}▀   ▀  ▀   ▀

$bld${f3}  ▄███████▄   ${f1}  ▄██████▄    ${f2}  ▄██████▄    ${f4}  ▄██████▄    ${f5}  ▄██████▄    ${f6}  ▄██████▄
$bld${f3}▄█████████▀▀  ${f1}▄${f7}█▀█${f1}██${f7}█▀█${f1}██▄  ${f2}▄${f7}█▀█${f2}██${f7}█▀█${f2}██▄  ${f4}▄${f7}█▀█${f4}██${f7}█▀█${f4}██▄  ${f5}▄${f7}█▀█${f5}██${f7}█▀█${f5}██▄  ${f6}▄${f7}█▀█${f6}██${f7}█▀█${f6}██▄
$bld${f3}███████▀      ${f1}█${f7}▄▄█${f1}██${f7}▄▄█${f1}███  ${f2}█${f7}▄▄█${f2}██${f7}▄▄█${f2}███  ${f4}█${f7}▄▄█${f4}██${f7}▄▄█${f4}███  ${f5}█${f7}▄▄█${f5}██${f7}▄▄█${f5}███  ${f6}█${f7}▄▄█${f6}██${f7}▄▄█${f6}███
$bld${f3}███████▄      ${f1}████████████  ${f2}████████████  ${f4}████████████  ${f5}████████████  ${f6}████████████
$bld${f3}▀█████████▄▄  ${f1}██▀██▀▀██▀██  ${f2}██▀██▀▀██▀██  ${f4}██▀██▀▀██▀██  ${f5}██▀██▀▀██▀██  ${f6}██▀██▀▀██▀██
$bld${f3}  ▀███████▀   ${f1}▀   ▀  ▀   ▀  ${f2}▀   ▀  ▀   ▀  ${f4}▀   ▀  ▀   ▀  ${f5}▀   ▀  ▀   ▀  ${f6}▀   ▀  ▀   ▀
EOF
        ;;
        *)
            echo retro!
        ;;
    esac
}

#
# Fortune shines over you
#
bullshit()
{
    if [[ $OSTYPE == darwin* ]]; then
        cowsay -f "$(find "$(brew --cellar cowsay)" -name '*.cow' | gshuf -n1)" "$(fortune)" | toilet -F gay -f term
    else
        cowsay -f "$(find /usr/share/cowsay/cows/ -name '*.cow' | shuf -n1)" "$(fortune)" | toilet -F gay -f term
    fi
}
