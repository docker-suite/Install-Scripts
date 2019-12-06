#!/usr/bin/env bash

# Locale
export LC_ALL=en_US.UTF-8

# Aliases
if [ -n "$BASH_VERSION" ]; then
    alias ls='ls -p --color=always --group-directories-first'
    alias l='ls -lp --color=always --group-directories-first'
    alias ll='ls -alp --color=always --group-directories-first'
    alias ..="cd .."
fi

# Colors
_clr_red="\e[31m"
_clr_green="\e[32m"
_clr_yellow="\e[33m"
_clr_reset="\e[m"
_ps1_clr_red="\[\e[31m\]"
_ps1_clr_green="\[\e[32m\]"
_ps1_clr_yellow="\[\e[33m\]"
_ps1_clr_reset="\[\e[m\]"

#
function _ps1_exit_status() {
  if [ "$?" == "0" ]; then
    printf "${_clr_green}>>${_clr_reset}"
  else
    printf "${_clr_red}>>${_clr_reset}"
  fi
}

#
function _ps1_user() {
  if [ "$(id -u)" == "0" ] ; then
    printf "${_clr_red}\\\\u@\\\\h${_clr_reset}"
  else
    printf "${_clr_green}\\\\u@\\\\h${_clr_reset}"
  fi
}

#
function _ps1_directory() {
  printf "${_clr_yellow}\w${_clr_reset}"
}

#
function _ps1_prompt() {
  if [ "$(id -u)" == "0" ] ; then
    printf "${_clr_green}#${_clr_reset}"
  else
    printf "${_clr_green}\$${_clr_reset}"
  fi
}

export PS1="\$(_ps1_exit_status) $(_ps1_user) $(_ps1_directory)\n\$(_ps1_prompt) "
