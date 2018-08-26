# URL: https://github.com/wfa207/bash-config
# Description: A barebones .bashrc file that includes some convenience aliases

# =============================================================================
# Python#{{{
# =============================================================================
export PYTHONSTARTUP=~/.pystartup.py
export NVM_DIR="$HOME/.nvm"
#}}}
# =============================================================================
# Powerline Configuration#{{{
# =============================================================================
# URL: https://github.com/b-ryan/powerline-shell
# Author: Buck Ryan (https://github.com/b-ryan)
# Description: Powerline prompt written purely in bash, with my own
# modifications

function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

#}}}
# =============================================================================
# Helper Functions#{{{
# =============================================================================
# Get current directory name
get_cur_dir() {
	printf $(basename $(pwd))
}

# Name tab with custom name
name_tab() {
	echo -ne "\033[0;"$1"\077"
}

# Old function that uses a global variable to determine the editor
venv_gvar_func() {
	if [ -z ${EDITOR+x} ] || [ -z ${EDITOR-x} ]; then EDITOR=vim
	fi
	name_tab $1
	workon $1 && $EDITOR .
}

# Current function that uses argument to determine editor; without an editor
# argument, the function simply activates the virtualenv
venv_arg_func() {
	if [ -z $2 ]; then workon $1 && . ~/.$1
	else
		if [ "$1" == "dev" ]; then workon $2 && . ~/.$2 &&
				tmux new -d -s my_session 'tmux splitw -dp 4\
					&& vim' &&
				tmux attach -t my_session
		else
			if [ -z $3 ]; then workon $2 && . ~/.$2 && $1 .
			else workon $2 && . ~/.$2 && $1 $2/$3
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

virtual_env_directory_nav() {
	local BASE_URL=/Users/wesauyueng/.virtualenvs/$1/lib/python2.7/site-packages
	if [ -z $2 ]; then cd $BASE_URL
	else cd $BASE_URL/$2
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
# Autocompletion for itermocil
complete -W "$(itermocil --list)" dev
#}}}
# =============================================================================
# Navigation Aliases#{{{
# =============================================================================
alias ls="ls -Al"						# List all files (incl. hidden)

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
alias gap="git add -Ap"
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
alias venv=virtual_env_directory_nav
#}}}
# =============================================================================
# General Aliases#{{{
# =============================================================================
alias .b=". ~/.bashrc"
alias runpy=python_script_utility
alias cl="clear"
alias dev-tmux="tmux splitw -bp 96 vim"
alias envy="EDITOR=subl envy"
alias kinesis-streams="aws firehose list-delivery-streams --limit 10000"
alias dev="itermocil --here"
#}}}
# =============================================================================
# Private Aliases#{{{
# =============================================================================
. ~/.privaliases.sh #}}}
# =============================================================================
# Fun stuff#{{{
# =============================================================================
flip() {
  echo;
  echo -en "( º_º）  ┬─┬   \r"; sleep .5;
  echo -en " ( º_º） ┬─┬   \r"; sleep .5;
  echo -en "  ( ºДº）┬─┬   \r"; sleep .5;
  echo -en "  (╯'Д'）╯︵⊏   \r"; sleep .3;
  echo -en "  (╯'□'）╯︵ ⊏  \r"; sleep .3;
  echo     "  (╯°□°）╯︵ ┻━┻"; sleep .3;
}
#}}}
# =============================================================================
# Node / React Native#{{{
# =============================================================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# =============================================================================#}}}
# =============================================================================

source $(which virtualenvwrapper.sh)
export Y_PATH=/Users/wesauyueng/.yy
export Y_DEV_PATH=/Users/wesauyueng/Development
source /Users/wesauyueng/.yy/bin/y

# added by travis gem
[ -f /Users/wesauyueng/.travis/travis.sh ] && source /Users/wesauyueng/.travis/travis.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
