#!/usr/bin/env bash
# Set virtual environment:: for python virtualenv

# Configure:
# Set `VIRTUAL_DIR_PATH` value to PATH to your virtual environments
# directory. By default it is set to '~/virtualenvs/'
#
# Usage:
# Added this file to your .bashrc or any local rc script.
# $ source /path/to/virtual.sh
#
# Now you can 'activate' the virtual environment by typing
# $ setv <YOUR VIRTUAL ENVIRONMENT NAME>
#
# For example:
# $ setv rango
#
# or type:
# setv [TAB] [TAB]

# To list all your virtual environments:
# $ setv -l
#
# To deactivate, type:
# $ deactivate

# TODO:
# - Create virtualenv with command something like: setv new_virt (if does not exists)
# - Delete virtualenv with command something like: setv -d old_virt_name

# ChangeLog :
# Fri Apr 25 12:41:40 IST 2014: TAB completion

# Path to your virtual environment directories
VIRTUAL_DIR_PATH="$HOME/virtualenvs/"

function _setvcomplete_()
{
    # bash-completion
    local cmd="${1##*/}" # to handle command(s) that's beain
                         # executed. Not necessary here as 'setv' is
                         # the only command
    local word=${COMP_WORDS[COMP_CWORD]} # Words thats being completed
    local xpat='${word}'		 # Filter pattern. Include
					 # only words in variable '$names'
    local names=$(ls ${VIRTUAL_DIR_PATH}) # Virtual environment names

    COMPREPLY=($(compgen -W "$names" -X "$xpat" -- "$word")) # 'compgen
							     # generates
							     # the
							     # results'
}

function _setv_help_() {
    # Echo help
    echo "Help: "
    echo -e "setv [-l] \t\t\t to list all virtual envs."
    echo -e "setv [virtual env name] \t to set virtual env."
}

function setv() {
    # Main function
    if [ $# -eq 0 ];
    then
	_setv_help_
    else
	if [ ${1} == "-l" ];
	then
	    echo -e "List of virtual environments you have under ${VIRTUAL_DIR_PATH}:\n"
	    LIST_OF_VIRTUALENVS=$(ls -1 ${VIRTUAL_DIR_PATH})
	    for virt in ${LIST_OF_VIRTUALENVS}
	    do
		echo ${virt}
	    done
	    # Check if the virtual directory exists in PATH
	elif [ -d ${VIRTUAL_DIR_PATH}${1} ];
	then
	    # Activate the virtual environment
	    source ${VIRTUAL_DIR_PATH}${1}/bin/activate
	else
	    # Else throw an error message
	    echo "Sorry, you don't have any virtual environment with that name"
	    _setv_help_
	fi
    fi
}

complete  -F _setvcomplete_ setv # call bash-complete. The compgen
				 # command accepts most of the same
				 # options that complete does but it
				 # generates results rather than just
				 # storing the rules for future use.
