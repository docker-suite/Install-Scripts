#!/bin/sh

# set -e : Exit the script if any statement returns a non-true return value.
set -e

# Update repository indexes
apk update

# curl must be installed: https://curl.haxx.se/
apk add curl

# Download the install-base script first and run it
curl -s -o /tmp/install-base.sh https://raw.githubusercontent.com/craftdock/Install-Scripts/master/alpine-base/install-base.sh
sh /tmp/install-base.sh


# Download files
if [ -n "$GH_TOKEN" ]; then
    gh-downloader -T=$GH_TOKEN -u=craftdock -r=Install-Scripts -p=alpine-runit/rootfs -o=/
else
    gh-downloader -u=craftdock -r=Install-Scripts -p=alpine-runit/rootfs -o=/
fi

# Remove all .gitkeep files
find /etc/crontabs -name ".gitkeep" -type f -delete

# Add packages
apk-install --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
    `# runit: http://smarden.org/runit/` \
    runit \
    && rm -f /sbin/runit \
    && rm -f /sbin/runit-init

# Permissions
chmod 0755 /entrypoint
chmod 0755 -R /etc/runit/*
[ $(ls /usr/local/bin | wc -l) -gt 0 ] && chmod 0755 /usr/local/bin/*
[ $(ls /usr/local/sbin | wc -l) -gt 0 ] && chmod 0755 /usr/local/sbin/*
