#!/usr/bin/env bash

# Run scripts in /etc/entrypoint.d
for file in $( find /etc/entrypoint.d/ -name '*.sh' -type f | sort -u ); do
    bash "${file}"
done

# Execute script with arguments
exec tini -- /usr/local/bin/runit "${@}"
