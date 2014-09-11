# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="fino-time-bash"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo encode64)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/home/mitesh/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Custome settings

# Autocomplete ssh
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'


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
	sudo ifconfig | egrep [0-9A-Za-z]{2}\(:[0-9A-Za-z]{2}\){5} | awk '{print $1 ":\t" $5}'
	
	echo -e "\nIP Address:"
	sudo ifconfig | grep "inet addr:" | cut -d: -f2 | awk '{print $1}'
	echo
}

# Download mp3 from DownloadMing site
function download_mp3
{
	wget $(curl "$1" | grep downloadming1.com | grep -v .zip | cut -d'"' -f2)
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
