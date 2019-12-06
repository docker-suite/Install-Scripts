#!/usr/bin/env bash
source /usr/local/lib/bash-logger.sh

# Run scripts in /etc/entrypoint.d
for file in $( find /etc/entrypoint.d/ -name '*.sh' -type f | sort -u ); do
    DEBUG "Running ${file}"
    bash ${file}
done

# Source scripts in /startup.d
for file in $( find /startup.d/ -name '*.sh' -type f | sort -u ); do
    DEBUG "Sourcing ${file}"
    source ${file}
done

# Run scripts in /startup.1.d
for file in $( find /startup.1.d/ -name '*.sh' -type f | sort -u ); do
    DEBUG "Running ${file}"
    bash ${file}
done

# Run scripts in /startup.2.d
for file in $( find /startup.2.d/ -name '*.sh' -type f | sort -u ); do
    DEBUG "Running ${file}"
    bash ${file}
done

# Execute script with arguments
exec tini -- /usr/local/bin/runit "${@}"
