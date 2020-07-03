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
export PATH=$PATH:$HOME/.scripts
export GDK_SCALE=2
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
#export TERM="alacritty"
#export TERMINAL="$TERM"
export EDITOR="vim"
export BROWSER="GDK_SCALE=2 firefox"
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
# Using lsd instead of ls
alias ll='lsd -Al'
alias lh='lsd -l'
alias lt='lsd --tree --depth 2'
alias lr='lsd -1'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias gpr='cd $HOME/projects'

# cd with fzf
alias fcd='cd $( find ./ -type d -print | fzf --info=inline )'

alias nb='newsboat'
alias hg='fc -l 1 | grep'
alias abook='abook -C ~/.config/mutt/abookrc -f ~/.config/mutt/addressbook'
alias vv='vim $HOME/.vimrc'
# turn touchpad on/off
alias tpO='touchpadOff'
alias tpC='touchpadOn'

# Function to open config files in vim
oc() {
	wasHere=$( pwd )
	cd $HOME
	cfg=$( du -a -d 2 $( ls -A | grep -Ev "(dropbox|chache|cargo)" | grep -e '^\.' ) | cut -f2 | fzf --info=inline --tac )
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

# Don't want to run the expressvpn daemon all the time, so start it to connect and stop when not using
alias exCN='sudo systemctl enable --now expressvpn; sleep 3; expressvpn connect usnj1'
alias exC='sudo systemctl enable --now expressvpn; sleep3; expressvpn connect'
alias exD='expressvpn disconnect && sudo systemctl disable --now expressvpn'

# runs an update and signals to i3blocks to refresh the pacupdate module
#alias pmU='sudo pmUpdate'
alias pmU='sudo pacman -Syu && pkill --signal RTMIN+9 -x dwmbar'

# dotfiles management
alias dotgit='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
######################

# powerline10k prompt customizations
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(background_jobs status root_indicator dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode command_execution_time)
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_last"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
GITSTATUS_LOG_LEVEL=DEBUG

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

