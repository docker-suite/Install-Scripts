#!/usr/bin/env bash

# Locale
export LC_ALL=en_US.UTF-8

# Aliases
if [ -n "$BASH_VERSION" ]; then
    alias ls='ls --color=always --group-directories-first'
    alias l='ls -l --color=always --group-directories-first'
    alias ll='ls -al --color=always --group-directories-first'
    alias ..="cd .."
fi

# New fancy prompt
PS1='`[ "$?" == "0" ] && echo "\[\e[32m\]>>\[\e[m\]" || echo "\[\e[31m\]>>\[\e[m\]"` `[ "$(id -u)" == "0" ] && echo "\[\e[31m\]\u\[\e[m\]\[\e[31m\]@\[\e[m\]\[\e[31m\]\h\[\e[m\]" || echo "\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]"` \[\e[33m\]\w\[\e[m\]\n`[ "$(id -u)" == "0" ] && echo "\[\e[32m\]#\[\e[m\]" || echo "\[\e[32m\]\\$\[\e[m\]"` '
