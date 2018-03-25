#!/bin/sh

# set -e : Exit the script if any statement returns a non-true return value.
set -e

# Update repository indexes
apk update

# curl must be installed: https://curl.haxx.se/
apk add curl

# jq must be installed: https://stedolan.github.io/jq/
apk add jq

# Folders
mkdir -p /usr/local/bin
mkdir -p /usr/local/sbin

# Install gh-downloader
curl -s -o /usr/local/sbin/gh-downloader https://raw.githubusercontent.com/CraftShell/gh-downloader/master/gh-downloader.sh
chmod +x /usr/local/sbin/gh-downloader

# Download files
if [ -n "$GH_TOKEN" ]; then
    gh-downloader -T=$GH_TOKEN -u=craftdock -r=Install-Scripts -p=alpine-base/rootfs -o=/
else
    gh-downloader -u=craftdock -r=Install-Scripts -p=alpine-base/rootfs -o=/
fi

# Add tools
curl -s -o /usr/local/sbin/templater https://raw.githubusercontent.com/CraftShell/templater/master/templater.sh
curl -s -o /usr/local/sbin/wait-host https://raw.githubusercontent.com/CraftShell/wait-host/master/wait-host.sh

# Permissions
chmod 0755 /entrypoint
[ $(ls /usr/local/bin | wc -l) -gt 0 ] && chmod 0755 /usr/local/bin/*
[ $(ls /usr/local/sbin | wc -l) -gt 0 ] && chmod 0755 /usr/local/sbin/*

# Add packages
apk-install --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
    `# curl: https://curl.haxx.se/` \
    curl \
    `# jq: https://stedolan.github.io/jq/` \
    jq \
    `# grep: http://www.gnu.org/software/grep/` \
    grep \
    `# sed: http://www.gnu.org/software/sed/` \
    sed \
    `# procps: https://gitlab.com/procps-ng/procps/` \
    procps \
    `# tini: https://github.com/krallin/tini` \
    `# Why tini: https://github.com/krallin/tini/issues/8` \
    tini \
    `# su-exec: https://github.com/ncopa/su-exec` \
    su-exec
