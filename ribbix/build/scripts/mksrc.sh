#!/bin/bash

#
# makes all source files included
# in arguments, takes options in
# option=value format
#

# save argument information
ARGV_ALL="$@"
ARGC_ALL="$#"
CALLER="$0"

ARG_RETURN_NAME= 
ARG_RETURN_VALUE=
ARG_RETURN_HASV=

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

