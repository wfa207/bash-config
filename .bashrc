# URL: https://github.com/wfa207/bash-config
# Description: A barebones .bashrc file that includes some convenience aliases

# =============================================================================
# Features#{{{
# =============================================================================
# Use vim keybindings in the terminal
set -o vi
#}}}
# =============================================================================
# Powerline Configuration#{{{
# =============================================================================
# URL: https://github.com/riobard/bash-powerline
# Author: Rio (https://github.com/riobard)
# Description: Powerline prompt written purely in bash

. ~/.bash-powerline.sh
#}}}
# =============================================================================
# Helper Functions#{{{
# =============================================================================
# Get current directory name
get_cur_dir() {
	printf $(basename $(pwd))
}

# Old function that uses a global variable to determine the editor
venv_gvar_func() {
	if [ -z ${EDITOR+x} ] || [ -z ${EDITOR-x} ]; then EDITOR=vim
	fi
	workon $1 && $EDITOR .
}

# Current function that uses argument to determine editor; without an editor
# argument, the function simply activates the virtualenv
venv_arg_func() {
	if [ -z $2 ]; then workon $1
	else
		if [ "$1" == "dev" ]; then workon $2 &&
				tmux new -d -s my_session 'tmux splitw -dp 4\
					&& vim' &&
				tmux attach -t my_session
		else 
			if [ -z $3 ]; then workon $2 && $1 .
			else workon $2 && $1 $2/$3
			fi
		fi
	fi
}

# Run project (must specify name of project / subproject and function name)
python_script_utility() {
	# $1 must be the (sub) project name and $2 must be the function name
	# If $3 exists, then we will run the script with arguments
	if [ -z "$3" ]; then python -m "$1".bin "$2"
	else
		local PY_ARG="$3"
		python -m "$1".bin "$2" "$PY_ARG" --option=single
	fi
}

# Activate virtual environment if we open up a new tab in a directory with a
# venv. Not currently used and in draft form

# tab_auto_venv() {
#     local dir_name=get_cur_dir
#     local venv_path="~/.virtualenvs/$get_cur_dir"
#     if [ -n $dir_name ]
#         then echo "$dir_name"
#     else echo "Could not find this virtual environment"
#     fi
# }
#}}}
# =============================================================================
# Config Variables#{{{
# =============================================================================
# Private config variables sourced externally
. ~/.configvar.sh
#}}}
# =============================================================================
# Navigation Aliases#{{{
# =============================================================================
alias ls="ls -A"						# List all files (incl. hidden)
alias lsa="ls -l"						# List with addl. details

# Do not include an alias for '.' (shortcut for source)
alias ..='cd ..'						# Go up a directory
alias ...='cd ../..'					# Go up 2 directories
alias ....='cd ../../..'				# Go up 3 directories
alias bk='cd -'							# Go back a directory
#}}}
# =============================================================================
# Git Aliases#{{{
# =============================================================================
alias gls="git log"
alias gtree="git log --graph --all"
alias ga="git add -A"
alias gap="git add -p"
alias gm="git commit -m"
alias gb="git branch"
alias gd="git diff"
alias gco="git checkout"
alias gc="git clone"
alias gr="git remote -v"
alias gp="git push"
alias gpu="git pull"
alias gs="git status"
alias gst="git stash"
alias gmbase="git merge-base"
alias grbase="git rebase -i"
alias gstd="git stash drop"
alias gstls="git stash list"
alias gstap="git stash apply"
#}}}
# =============================================================================
# Virtual Env Aliases#{{{
# =============================================================================
# This function takes the first parameter passed after wrk_func and activates
# the associated virtual environment while simultaneously starting vim
alias wrk=venv_arg_func
alias nowrk="deactivate && cd"
#}}}
# =============================================================================
# General Aliases#{{{
# =============================================================================
alias .b=". ~/.bashrc"
alias runpy=python_script_utility
alias cl="clear"
alias dev-tmux="tmux splitw -bp 96 vim"
#}}}
# =============================================================================
# Private Aliases#{{{
# =============================================================================
. ~/.privaliases.sh #}}}
# =============================================================================

