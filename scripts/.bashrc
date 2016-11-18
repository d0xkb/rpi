# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=
HISTFILESIZE=

# don't put duplicate lines or lines starting with space in the history
# see bash(1) for more options
HISTCONTROL=ignoreboth

# display and log timestamp
HISTTIMEFORMAT="[%F %T] "

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# locale setup
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# few aliases
alias ll='ls -halF --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias agu='apt-get update'
alias acs='apt-cache search'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
