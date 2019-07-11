# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Start bash vi mode
set -o vi

export PATH=$PATH:$HOME/.scripts
#export GDK_SCALE=2
export TERM="termite"
export TERMINAL="$TERM"
export EDITOR="vim"
export BROWSER="firefox"
export MKLROOT="/opt/intel/compilers_and_libraries_2019.1.144/linux/mkl"
# Prompt
export PS1="[\[\033[0;34m\]\s\[\033[0;38m\]|\[\033[0;38m\]\u@\[\033[1;32m\]\h \[\033[1;36m\]\W\[\033[0m\]]\$ "
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Using lsd instead of ls
alias ll='lsd -al'
alias lh='lsd -l'
alias lt='lsd --tree'
alias lr='lsd -1'
alias la='ls -A'
alias l='ls -CF'

alias nb='newsboat'
alias hg='history | grep'
alias exCN='expressvpn connect usnj1'
alias exC='expressvpn connect'
alias exD='expressvpn disconnect'

# runs an update and signals to i3blocks to refresh the pacupdate module
alias pmU='sudo pacman -Syu && kill -s RTMIN+2 $( ps -ef | grep i3blocksTop | grep -v grep | tr -s " " | cut -d " " -f2 )'

# dotfiles management
alias dotgit='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
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
