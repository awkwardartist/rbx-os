#!/bin/bash

#
# makes all source files included
# in arguments, takes options in
# option=value format
#
# usage:
# sources are space-separated
# mksrc.sh [option=...] SOURCES

#
# Global Argument Info
#
ARG_RETURN_NAME=   ARG_RETURN_VALUE=
ARG_RETURN_HASV=   ARG_RETURN_ERROR=

ARGV_ALL="$@" ARGV=($@)
ARGC_ALL="$#" ARGC=$#
MKSRC_SCRIPT="$0"

CALLER="$0 $ARGV_ALL"

ARG_RETURN_NAME= 
ARG_RETURN_VALUE=
ARG_RETURN_HASV=

# current working source file
# state and identifying information
_TARGET_DIR=
_TARGET_FILE=

# compiler / assembler paths
# and language information
_TARGET_STDC_COMPILER=/bin/gcc
_TARGET_CPP_COMPILER=/bin/g++
_TARGET_ASSEMBLER=/usr/bin/nasm

# all project language 
# identifiers
PROJECT_LANGS=(
    "standard-c"    # standard C language
    "standard-c++"  # C++/CPP lang
    "x86_64-nasm"   # Assembly language
)

# script options
# (bash array [])
_OPTION_NAMES=()
_OPTION_VALUES=()

# arg_add_option (name, value):
# adds an option to the global option
# lists (_OPTION_NAMES & _OPTION_VALUES)
arg_add_option () {
    local name="$1" value="$2"
    local hasv=true

    # test if value was provided
    if [ -z "$value" ]
        then hasv=false; fi

}

# returns option name if arg is
# a script option, null otherwise.
# also fills globals: 
# ARG_RETURN_NAME and ARG_RETURN_VALUE
arg_is_option () {
    local arg="$@" hasv=true
    local value= name=

    # get name and value if
    # argument is an option
    if [ -n "$(echo $arg | grep '=')" ];
        # $arg is an option, parse 
        # option name and value: 
        then value="${arg##*=}";
        name="${arg%%=*}"; 
        
        # test fetched name/value
        if [ -z "$name" ]
            then return; 
        elif [ -z "$value" ]
            then hasv=false;
        fi;

        # return fetched data:
        ARG_RETURN_HASV="$hasv"
        ARG_RETURN_NAME="$name"
        ARG_RETURN_VALUE="$value"

        # return option name:
        echo "$name" && return;
    fi
}


#
# Begin Execution
# (Script Entrypoint)
#

# find options:
for a in $@;
    # loop through 
    # all arguments
done
