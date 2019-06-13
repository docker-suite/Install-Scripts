#!/usr/bin/env bash

# Run scripts in /etc/entrypoint.d
for file in $( find /etc/entrypoint.d/ -name '*.sh' -type f | sort -u ); do
    [ -x "${file}" ] && bash "${file}"
done

# Execute script with arguments
exec tini -- "${@}"
