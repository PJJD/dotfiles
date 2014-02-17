#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

set -o vi
#set -o noclobber
set -o nounset
shopt -s cdable_vars
shopt -s extglob
# Use vim instead of vi, aliased parameters can be passed
alias vi='/usr/bin/vim '
# Makes aliased directories cd-able
alias cd='cd '

HISTTIMEFORMAT='%a %d/%m/%Y %H:%M:%S%t'

export EDITOR='/usr/bin/vim'

export PATH=/usr/lib/qt4/bin:$PATH
export PATH=~/bin:$PATH

# To get 256 color-support in tmux
alias tmux='tmux -2'
