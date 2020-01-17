#!/bin/sh

# set -e : Exit the script if any statement returns a non-true return value.
set -e

# Update repository indexes
apk update

# curl must be installed: https://curl.haxx.se/
apk add --no-cache curl

# jq must be installed: https://stedolan.github.io/jq/
apk add --no-cache jq

# Folders
mkdir -p /usr/local/bin
mkdir -p /usr/local/lib
mkdir -p /usr/local/sbin

# Add tools
curl -s -o /usr/local/sbin/gh-downloader https://raw.githubusercontent.com/bash-suite/gh-downloader/master/gh-downloader.sh
curl -s -o /usr/local/sbin/templater https://raw.githubusercontent.com/bash-suite/templater/master/templater.sh
curl -s -o /usr/local/sbin/wait-host https://raw.githubusercontent.com/bash-suite/wait-host/master/wait-host.sh
curl -s -o /usr/local/sbin/mvlink https://raw.githubusercontent.com/bash-suite/mvlink/master/mvlink.sh
curl -s -o /usr/local/lib/bash-logger.sh https://raw.githubusercontent.com/bash-suite/bash-logger/master/bash-logger.sh
curl -s -o /usr/local/lib/persist-env.sh https://raw.githubusercontent.com/bash-suite/persist-env/master/persist-env.sh

# Download root files
if [ -z "$1" ]; then
    if [ -n "$GH_TOKEN" ]; then
        sh /usr/local/sbin/gh-downloader -T="$GH_TOKEN" -u=docker-suite -r=Install-Scripts -p=alpine-base/rootfs -o=/
    else
        sh /usr/local/sbin/gh-downloader -u=docker-suite -r=Install-Scripts -p=alpine-base/rootfs -o=/
    fi
fi

# Make bin and sbin files accessible and executable
[ "$(find /usr/local/bin -type f  | wc -l)" -gt "0" ] && chmod 0755 /usr/local/bin/*
[ "$(find /usr/local/sbin -type f | wc -l)" -gt "0" ] && chmod 0755 /usr/local/sbin/*

# Add more cron period
chmod 600 /etc/crontabs/root
mkdir -p /etc/periodic/daily_1am
mkdir -p /etc/periodic/daily_2am
mkdir -p /etc/periodic/daily_3am
mkdir -p /etc/periodic/daily_4am
mkdir -p /etc/periodic/daily_5am
mkdir -p /etc/periodic/daily_6am
mkdir -p /etc/periodic/daily_7am
mkdir -p /etc/periodic/daily_8am
mkdir -p /etc/periodic/daily_9am
mkdir -p /etc/periodic/daily_10am
mkdir -p /etc/periodic/daily_11am
mkdir -p /etc/periodic/daily_12am
mkdir -p /etc/periodic/daily_1pm
mkdir -p /etc/periodic/daily_2pm
mkdir -p /etc/periodic/daily_3pm
mkdir -p /etc/periodic/daily_4pm
mkdir -p /etc/periodic/daily_5pm
mkdir -p /etc/periodic/daily_6pm
mkdir -p /etc/periodic/daily_7pm
mkdir -p /etc/periodic/daily_8pm
mkdir -p /etc/periodic/daily_9pm
mkdir -p /etc/periodic/daily_10pm
mkdir -p /etc/periodic/daily_11pm
mkdir -p /etc/periodic/daily_12pm
mkdir -p /etc/periodic/weekly_sunday
mkdir -p /etc/periodic/weekly_monday
mkdir -p /etc/periodic/weekly_tuesday
mkdir -p /etc/periodic/weekly_wednesday
mkdir -p /etc/periodic/weekly_thursday
mkdir -p /etc/periodic/weekly_friday
mkdir -p /etc/periodic/weekly_saturday
mkdir -p /etc/periodic/monthly_january
mkdir -p /etc/periodic/monthly_february
mkdir -p /etc/periodic/monthly_march
mkdir -p /etc/periodic/monthly_april
mkdir -p /etc/periodic/monthly_may
mkdir -p /etc/periodic/monthly_june
mkdir -p /etc/periodic/monthly_july
mkdir -p /etc/periodic/monthly_august
mkdir -p /etc/periodic/monthly_september
mkdir -p /etc/periodic/monthly_october
mkdir -p /etc/periodic/monthly_november
mkdir -p /etc/periodic/monthly_december

# Make startup scripts accessible and executable
[ -d /startup.d ]   && [ "$(find /startup.d -name '*.sh' -type f | wc -l)" -gt "0" ]   && chmod 0755 /startup.d/*.sh
[ -d /startup.1.d ] && [ "$(find /startup.1.d -name '*.sh' -type f | wc -l)" -gt "0" ] && chmod 0755 /startup.1.d/*.sh
[ -d /startup.2.d ] && [ "$(find /startup.2.d -name '*.sh' -type f | wc -l)" -gt "0" ] && chmod 0755 /startup.2.d/*.sh

# Make entrypoint.d scripts accessible and executable
chmod 0755 /etc/entrypoint.d/*.sh
chmod 0755 /entrypoint.sh

# Clean .gitkeep files
[ -d /startup.d ]   && find /startup.d -maxdepth 1 -type f -iname '\.gitkeep' -delete
[ -d /startup.1.d ] && find /startup.1.d -maxdepth 1 -type f -iname '\.gitkeep' -delete
[ -d /startup.2.d ] && find /startup.2.d -maxdepth 1 -type f -iname '\.gitkeep' -delete

# Add packages
apk-install --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
    `# bash: https://tiswww.case.edu/php/chet/bash/bashtop.html/` \
    bash \
    `# coreutils: https://www.gnu.org/software/coreutils/` \
    coreutils \
    `# curl: https://curl.haxx.se/` \
    curl \
    `# grep: http://www.gnu.org/software/grep/` \
    grep \
    `# jq: https://stedolan.github.io/jq/` \
    jq \
    `# procps: https://gitlab.com/procps-ng/procps/` \
    procps \
    `# sed: http://www.gnu.org/software/sed/` \
    sed \
    `# shadow: Add usermod and groupmod` \
    shadow \
    `# su-exec: https://github.com/ncopa/su-exec` \
    su-exec \
    `# tini: https://github.com/krallin/tini` \
    `# Why tini: https://github.com/krallin/tini/issues/8` \
    tini
