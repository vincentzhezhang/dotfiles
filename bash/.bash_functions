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

#
# Some useful tips. TODO: add more tips for other frequently used apps
#
bulltruth()
{
    cowstates=(b d g p s t w t y)
    cowstate=${cowstates[$RANDOM % ${#cowstates[@]}]}
    git-tip | fold -s -w 60 | cowthink -"${cowstate}" -n | toilet -F gay -f term
}

#
# git prompt snippet, use plumbing commands for reliable states parsing
#
git_prompt()
{
    # check if current working directory is a git tracked directory
    if (git rev-parse --git-dir &> /dev/null); then
        git_dir="$(git rev-parse --git-dir)"
        current_branch="$(git symbolic-ref --short HEAD 2> /dev/null)"
        current_status="$(git status --porcelain 2> /dev/null)"

        # detect rebase in progress
        rb_merge_dir="${git_dir}/rebase-merge"
        rb_apply_dir="${git_dir}/rebase-apply"

        if [[ -d $rb_merge_dir || -d $rb_apply_dir ]]; then
            echo "${BRED}[R]${COFF}"
            return
        fi

        if [[ -z $current_status ]]; then
            unset dirty_state
        else
            local dirty_state=''
            #
            # NOTE: for matching patterns, please refer to git status manual
            #
            # stats for files not staged
            local unstaged_state=''
            modified_count=$(echo "$current_status" | grep -E '^.M' --count)
            deleted_count=$(echo "$current_status" | grep -E '^.D' --count)
            untracked_files_count=$(echo "$current_status" | grep -E '^\?\? ' --count)

            if [[ $modified_count -gt 0 ]]; then
                unstaged_state+="${BLUE}m${modified_count}${COFF}"
            fi
            if [[ $deleted_count -gt 0 ]]; then
                unstaged_state+="${RED}d${deleted_count}${COFF}"
            fi
            if [[ $untracked_files_count -gt 0 ]]; then
                unstaged_state+="${VIOLET}u${untracked_files_count}${COFF}"
            fi

            # stats for staged files
            local staged_state=''
            staged_new_count=$(echo "$current_status" | grep -E '^A' --count)
            staged_modified_count=$(echo "$current_status" | grep -E '^M' --count)
            staged_deleted_count=$(echo "$current_status" | grep -E '^D' --count)
            if [[ $staged_new_count -gt 0 ]]; then
                staged_state+="${GREEN}A${staged_new_count}${COFF}"
            fi
            if [[ $staged_modified_count -gt 0 ]]; then
                staged_state+="${BLUE}M${staged_modified_count}${COFF}"
            fi
            if [[ $staged_deleted_count -gt 0 ]]; then
                staged_state+="${RED}D${staged_deleted_count}${COFF}"
            fi

            if [[ -n "$unstaged_state" ]]; then
                dirty_state+="$unstaged_state"
            fi

            if [[ -n "$unstaged_state" && -n "$staged_state" ]]; then
                dirty_state+="${ORANGE}|${COFF}"
            fi

            if [[ -n "$staged_state" ]]; then
                dirty_state+="$staged_state"
            fi

            dirty_state="${ORANGE}*(${COFF}${dirty_state}${ORANGE})${COFF}"
        fi

        # only check status against tracking upstream when it exists
        if (git branch -r | grep -q "$current_branch"); then
            local_rev=$(git rev-parse @)
            remote_rev=$(git rev-parse '@{u}')
            base_rev=$(git merge-base @ '@{u}')

            if [ "$local_rev" = "$remote_rev" ]; then
                repo_state="${GREEN}[✓]${COFF}"
            elif [ "$local_rev" = "$base_rev" ]; then
                repo_state="${YELLOW}↓$(git rev-list "$base_rev".."$remote_rev" --count)${COFF}"
            elif [ "$remote_rev" = "$base_rev" ]; then
                repo_state="${YELLOW}↑$(git rev-list "$base_rev".."$local_rev" --count)${COFF}"
            else
                repo_state="${BRED}↑$(git rev-list "$base_rev".."$local_rev" --count)${COFF}"
                repo_state+="${BRED}↓$(git rev-list "$base_rev".."$remote_rev" --count)${COFF}"
            fi
        else
            repo_state="${BLUE}[?]${COFF}"
        fi

        branch_prompt="${BYELLOW}@${COFF}${CYAN}${current_branch}${COFF}"
        git_str="${branch_prompt}${repo_state}${dirty_state}"
        echo "$git_str"
    else
        return 2
    fi
}

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
