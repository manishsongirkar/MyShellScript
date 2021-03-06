# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=20000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias h='history | grep $1' #Requires one input

alias wwwov='ssh www-data@ov.hauteliving.com'
alias rootov='ssh root@ov.hauteliving.com'
alias wwwsu='ssh www-data@su.hauteliving.com'
alias rootsu='ssh root@su.hauteliving.com'

## Start calculator with math support ##
alias bc='bc -l'

## get rid of command not found ##
alias cd..='cd ..'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

## pass options to free ##
alias meminfo='free -m -l -t'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'

## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# When Commands Fail Turn PS1 In RED
PS1="\`if [ \$? = 0 ]; then echo \[\e[34m\]^_^[\u@\h:\w]\\$ \[\e[0m\]; else echo \[\e[31m\]O_O[\u@\h:\w]\\$ \[\e[0m\]; fi\`"

# Set Default Editor as vim
export VISUAL=vim

# Wikipedia
function wiki
{
    dig +short txt $(echo $* | sed 's/ /_/g').wp.dg.cx|sed -E "s/\" \"|^\"|\"$|\\\\//g" | fmt;
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Update system Packages
function update_package ()
{
    sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get autoremove && sudo apt-get clean all;
    clear;
}

# Take Backup of my Home Directory
function my_backup ()
{
    rsync -avzhm --exclude "Desktop" --exclude "Documents" --exclude "SyncDrive" --exclude "Downloads" --exclude ".cache" --exclude "Music" --exclude "NetBeansProjects" --exclude "Pictures" --exclude "Public" --exclude "Templates" --exclude ".xsession-errors" --exclude ".xsession-errors.old" --exclude "Ubuntu One" --exclude "Videos" --exclude "examples.desktop" /home/manish/ /media/manish/ManishPassport/Manish_Linux_Backup/
}

# Show Mac Address and IP Address
function mac_id ()
{
    echo -e "\nMac Address:"
    ifconfig | egrep [0-9A-Za-z]{2}\(:[0-9A-Za-z]{2}\){5} | awk '{print $1 ":\t" $5}'

    echo -e "\nIP Address:"
    ifconfig | grep "inet addr:" | cut -d: -f2 | awk '{print $1}'
    echo
}

# Clear all cache files from system
function cache_clean
{
    rm -rf ~/.cache/thumbnails/fail/gnome-thumbnail-factory/* ~/.cache/thumbnails/large/* ~/.cache/thumbnails/normal/* ~/.cache/google-chrome/Default/Cache/* ~/.cache/folks/avatars/* ~/.cache/rhythmbox/album-art/* ~/.cache/shotwell/thumbs/thumbs128/* ~/.cache/shotwell/thumbs/thumbs360/* ~/.thumbnails/normal/* ~/.cache/media-art/*;
    clear;
}

# Install Grunt Packages
function grunt_package
{
    while read result; do sudo npm install $result --save-dev &&; done < <(cat package.json | sed -e 's/[{}]/''/g' | grep grunt | cut -d '"' -f 2 | sort -u)
}

alias eeupdate="wget -qO eeup http://rt.cx/eeup && sudo bash eeup"