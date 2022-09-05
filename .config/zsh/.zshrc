# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh config file

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# history settings
HISTFILE="${ZDOTDIR}/.history"
HISTSIZE=50000
SAVEHIST=${HISTSIZE}
SHARE_HISTORY="true"
HIST_IGNORE_ALL_DUPS="true"
HIST_IGNORE_SPACE="true"
HIST_NO_STORE="true"

# Do not check mail
MAILCHECK=0

# vi mode
bindkey -v
export KEYTIMEOUT=1

# misc. variables
export PATH=$PATH:$HOME/.scripts:$HOME/.local/bin
export GDK_SCALE=2
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export BAT_THEME="Nord"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
#export TERM="alacritty"
#export TERMINAL="$TERM"
export EDITOR="nvim"
export BROWSER="firefox"
export MAIL=$HOME/.mail
export VIFM="$HOME/.config/vifm"
export DPBX="$HOME/extra/Dropbox"

# to colorize less
export LESS_TERMCAP_mb=$'\e[1;34m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;35m'

#### aliases ######
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rg='rg --color=always'
alias rm='rm -I'
alias df='df -h'
alias gaa='git add --all'
alias gau='git add -u'
alias gst='git status'
alias gcm='git commit -m'
alias lsail='ssh -i $HOME/.ssh/LightsailDefaultKey-us-east-1.pem'
# Using lsd instead of ls
alias ll='exa --long --all --git --icons'
alias lh='exa --long --git --icons'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias gpr='cd $HOME/projects'
# neovim shortcut
alias vi=nvim

# cd with fzf
alias fcd='cd $( find ./ -type d -print | fzf --info=inline )'

alias nb='newsboat'
alias hg='fc -l 1 | grep'
alias abook='abook -C ~/.config/mutt/abookrc -f ~/.config/mutt/addressbook'
alias vv='nvim $HOME/.config/nvim/init.vim'
alias jcterr='journalctl -p 3 -xb'
# turn touchpad on/off
alias tpO='touchpadOff'
alias tpC='touchpadOn'

# Function to back up the projects directory
bcp() {
	curDir=$( pwd )
	cd $HOME
	rsync -avz -e ssh projects/ aniki:/tank/blacklagoonSync/projects
	cd $curDir
}
# Function to open config files in vim
oc() {
	wasHere=$( pwd )
	cd $HOME
	cfg=$( du -a -d 3 $( ls -A | grep -e '^\.' | grep -E "(config|rc$|xprofile|newsboat)" ) | grep -v Cache | awk '{print $2}'| fzf --info=inline --tac )
	if [[ -n "$cfg" ]]; then
		$EDITOR $cfg
	fi
	cd $wasHere
}
# Function for searching history
hs() {print -z $( fc -l 1 | grep -v 'hg ' | grep -v 'exit$' | sed 's/^\s*[0-9]\+\s\+//' | sort | uniq | fzf --info=inline --tac )}

# Function for searching pacman
pmS(){
	res=$( pacman -Ss | fzf --info=inline | sed 's/^\w\+\///' | cut -d ' ' -f1 )
	if [[ -n "$res" ]]; then
		print -z "sudo pacman -S $res"
	fi
}
# Function to change the background image
sbg(){cp $HOME/images/backgrounds/$( ls $HOME/images/backgrounds | fzf --info=inline ) $HOME/images/background.jpg > /dev/null 2>&1 && feh --bg-fill $HOME/images/background.jpg;}
# Function to change the lock screen image
slck(){cp $HOME/images/lockScreens/$( ls $HOME/images/lockScreens | fzf --info=inline ) $HOME/images/lockImage.png > /dev/null 2>&1 ;}
# Function to compile and file changes to dwm; must be run in the dwm directory
mkdwm () {
	brch=$( git rev-parse --abbrev-ref HEAD )
	if [ "$brch" != "mugen" ]; then
		echo "wrong branch $brch"
		exit(1)
	fi
	make
	sudo make install clean
	git diff master > ../dwm-tonymugen.diff
	mv -v ../dwm-tonymugen.diff $HOME/systemConf
}
# Same for dmenu
mkdmenu () {
	brch=$( git rev-parse --abbrev-ref HEAD )
	if [ "$brch" != "mugen" ]; then
		echo "wrong branch $brch"
		exit(1)
	fi
	make
	sudo make install clean
	git diff master > ../dmenu-tonymugen.diff
	mv -v ../dmenu-tonymugen.diff $HOME/systemConf
}

# Don't want to run the expressvpn daemon all the time, so start it to connect and stop when not using
exCN () {
	sudo systemctl enable --now expressvpn
	sleep 3
	expressvpn connect usnj1 && sync
	pkill --signal RTMIN+7 -x dwmbar
}

exC () {
	sudo systemctl enable --now expressvpn
	sleep 3
	expressvpn connect $1 && sync
	pkill --signal RTMIN+7 -x dwmbar
}

exD () {
	expressvpn disconnect && sync
	sudo systemctl disable --now expressvpn
	sudo systemctl restart NetworkManager
	pkill --signal RTMIN+7 -x dwmbar
}
# restart NetworkManager
nmResart () {
	sudo systemctl restart NetworkManager
	pkill --signal RTMIN+7 -x dwmbar
}

# mount a LUKS usb drive
mtLUSB () {
	sudo cryptsetup open $1 cryptUsb
	sudo mount /dev/mapper/cryptUsb $HOME/usb
}
# unount a LUKS usb drive
umtLUSB () {
	sudo umount usb
	sudo cryptsetup close /dev/mapper/cryptUsb
}
# runs an update and signals to i3blocks to refresh the pacupdate module
#alias pmU='sudo pmUpdate'
alias pmU='sudo pacman -Syu && pkill --signal RTMIN+9 -x dwmbar'

# dotfiles management
alias dg='/usr/bin/git --git-dir=$HOME/.dotFiles/ --work-tree=$HOME'
######################

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#867483"

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/.p10k.zsh

