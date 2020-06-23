#!/usr/bin/env bash
# shellcheck disable=SC1090

###
### Source libs in /etc/entrypoint.d
###
for file in $( find /etc/entrypoint.d/ -name '*.sh' -type f | sort -u ); do
    source "${file}"
done

###
### Source custom user supplied libs in /startup.d
###
source_scripts "/startup.d"

###
### Run custom user supplied scripts
###
execute_scripts "/startup.1.d"
execute_scripts "/startup.2.d"

###
### Execute only if arguments exist
###
if [ ! "$#" = "0" ]; then
    ### Run with the correct user
    if [ -n "$USER" ]; then
        set -- su-exec "$USER" "$@"
    fi

    ### Execute script with arguments
    exec tini -- "${@}"
fi
