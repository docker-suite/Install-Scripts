#!/usr/bin/env bash
# shellcheck disable=SC1091

## Make runit scripts accessible and executable
[ -d /etc/runit ] && chmod 0755 -R /etc/runit/*
