#!/usr/bin/env bash

# Run scripts in /etc/entrypoint.d
for file in $( find /etc/entrypoint.d/ -name '*.sh' -type f | sort -u ); do
    bash "${file}"
done

# Source scripts in /startup.d
for file in $( find /startup.d/ -name '*.sh' -type f | sort -u ); do
    source "${file}"
done

# Run scripts in /startup.1.d
for file in $( find /startup.1.d/ -name '*.sh' -type f | sort -u ); do
    bash "${file}"
done

# Run scripts in /startup.2.d
for file in $( find /startup.2.d/ -name '*.sh' -type f | sort -u ); do
    bash "${file}"
done

# Execute script with arguments
exec tini -- /usr/local/bin/runit "${@}"
