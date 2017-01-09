# URL: https://github.com/wfa207/bash-config
# Description: A barebones .bashrc file that includes some convenience aliases 

# ============================================================================
# Powerline Configuration#{{{
# ============================================================================
# URL: https://github.com/riobard/bash-powerline
# Author: Rio (https://github.com/riobard)
# Description: Powerline prompt written purely in bash

. ~/.bash-powerline.sh
#}}}
# ============================================================================
# Config Variables#{{{
# ============================================================================
. ~/.configvar.sh
#}}}
# ============================================================================
# Navigation#{{{
# ============================================================================
alias ls="ls -A"						# List all files (incl. hidden)
alias lsa="ls -l"						# List with addl. details

# Do not include an alias for '.' (shortcut for source)
alias ..='cd ..'						# Go up a directory
alias bk='cd -'							# Go back a directory
#}}}
# ============================================================================
# Git Aliases#{{{
# ============================================================================
alias ga="git add"
alias gm="git commit -m"
alias gb="git branch"
alias gco="git checkout"
alias gc="git clone"
alias gr="git remote -v"
alias gp="git push"
alias gpu="git pull"
alias gs="git status"
#}}}
# ============================================================================
# Virtual Env Aliases#{{{
# ============================================================================
# This function takes the first parameter passed after wrk_func and activates
# the associated virtual environment while simultaneously starting vim

wrk_func() {
	workon $1 && vim .
}

alias wrk=wrk_func
alias nowrk="deactivate"
#}}}
# ============================================================================
# Private Aliases
# ============================================================================
. ~/.privaliases.sh
# ============================================================================

