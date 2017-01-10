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
alias ...='cd ../..'					# Go up 2 directories
alias ....='cd ../../..'				# Go up 3 directories
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

# Old function that uses a global variable to determine the editor
wrk_gvar_func() {
	if [ -z ${EDITOR+x} ] || [ -z ${EDITOR-x} ]
		then EDITOR=vim
	fi
	workon $1 && $EDITOR .
}

# Current function that uses argument to determine editor; without an editor
# argument, the function simply activates the virtualenv
wrk_arg_func() {
	if [ -z $2 ]
		then workon $1
	else
		workon $2 && $1 .
	fi
}

alias wrk=wrk_arg_func
alias nowrk="deactivate"
#}}}
# ============================================================================
# General Aliases#{{{
# ============================================================================
alias .b=". ~/.bashrc" 
alias runproj="python -m $(basename $(pwd)).bin"#}}}
# ============================================================================
# Private Aliases#{{{
# ============================================================================
. ~/.privaliases.sh #}}}
# ============================================================================

