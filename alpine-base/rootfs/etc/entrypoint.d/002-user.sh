#!/usr/bin/env bash
# shellcheck disable=SC1091

## User which will be running the main process
USER=$(env_get "USER")

## Auto load /etc/profile for all known users
echo "source /etc/profile" > /root/.ashrc
echo "source /etc/profile" > /root/.bashrc
([[ -d "$HOME"  ]] && echo "source /etc/profile" > "$HOME/.ashrc") || true
([[ -d "$HOME"  ]] && echo "source /etc/profile" > "$HOME/.bashrc") || true
([[ -d "$(getent passwd "$USER" | cut -d: -f6)"  ]] && echo "source /etc/profile" > "$(getent passwd "$USER" | cut -d: -f6)/.ashrc") || true
([[ -d "$(getent passwd "$USER" | cut -d: -f6)"  ]] && echo "source /etc/profile" > "$(getent passwd "$USER" | cut -d: -f6)/.bashrc") || true

## direct sourcing if the user do not have a home folder
if [[ "$HOME" == "/" ]]; then
    source /etc/profile
fi
