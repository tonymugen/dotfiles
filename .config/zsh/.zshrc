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
export TERM="termite"
export TERMINAL="$TERM"
export EDITOR="vim"
export BROWSER="firefox"
export MAIL=$HOME/.mail
export MKLROOT="/opt/intel/compilers_and_libraries_2019.1.144/linux/mkl"

#### aliases ######
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# Using lsd instead of ls
alias ll='lsd -al'
alias lh='lsd -l'
alias lt='lsd --tree --depth 2'
alias lr='lsd -1'
alias la='ls -A'
alias l='ls -CF'

alias nb='newsboat'
alias hg='fc -l 1 | grep'
alias abook='abook -C ~/.config/mutt/abookrc -f ~/.config/mutt/addressbook'

# Don't want to run the expressvpn daemon all the time, so start it to connect and stop when not using
alias exCN='sudo systemctl enable --now expressvpn; sleep 3; expressvpn connect usnj1'
alias exC='sudo systemctl enable --now expressvpn; sleep3; expressvpn connect'
alias exD='expressvpn disconnect && sudo systemctl disable --now expressvpn'

# runs an update and signals to i3blocks to refresh the pacupdate module
alias pmU='sudo pmUpdate'

# dotfiles management
alias dotgit='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
######################

# powerline9k prompt customizations
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(background_jobs status root_indicator dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode)
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_last"

source /usr/share/zsh-theme-powerlevel10k/powerlevel9k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
