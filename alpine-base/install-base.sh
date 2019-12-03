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
if [ -n "$GH_TOKEN" ]; then
    sh /usr/local/sbin/gh-downloader -T=$GH_TOKEN -u=docker-suite -r=Install-Scripts -p=alpine-base/rootfs -o=/
else
    sh /usr/local/sbin/gh-downloader -u=docker-suite -r=Install-Scripts -p=alpine-base/rootfs -o=/
fi

# Make bin and sbin files accessible and executable
[ "$(ls /usr/local/bin | wc -l)" -gt "0" ] && chmod 0755 /usr/local/bin/*
[ "$(ls /usr/local/sbin | wc -l)" -gt "0" ] && chmod 0755 /usr/local/sbin/*

# Make startup scripts accessible and executable
[ "$(ls /startup.1.d | wc -l)" -gt "0" ] && chmod 0755 /startup.1.d/*.sh
[ "$(ls /startup.2.d | wc -l)" -gt "0" ] && chmod 0755 /startup.2.d/*.sh

# Make entrypoint accessible and executable
chmod 0755 /etc/entrypoint.d/*
chmod 0755 /entrypoint.sh

# Clean .gitkeep files
find /etc/entrypoint.source.d -maxdepth 1 -type f -iname '\.gitkeep' -delete
find /startup.1.d -maxdepth 1 -type f -iname '\.gitkeep' -delete
find /startup.2.d -maxdepth 1 -type f -iname '\.gitkeep' -delete

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
