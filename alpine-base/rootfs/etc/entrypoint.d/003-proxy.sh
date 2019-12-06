#!/usr/bin/env bash

# Add libraries
source /usr/local/lib/bash-logger.sh
source /usr/local/lib/persist-env.sh

_set_proxy() {
    local http_proxy=$(env_get "http_proxy")
    local https_proxy=$(env_get "https_proxy")
    local HTTP_PROXY=$(env_get "HTTP_PROXY")
    local HTTPS_PROXY=$(env_get "HTTPS_PROXY")

    # Make sure http_proxy and HTTP_PROXY exists
    [ -n "$http_proxy"  ] && [ -z "$HTTP_PROXY"  ] && HTTP_PROXY="$http_proxy"
    [ -n "$https_proxy" ] && [ -z "$HTTPS_PROXY" ] && HTTPS_PROXY="$https_proxy"
    [ -n "$HTTP_PROXY"  ] && [ -z "$http_proxy"  ] && http_proxy="$HTTP_PROXY"
    [ -n "$HTTPS_PROXY" ] && [ -z "$https_proxy" ] && https_proxy="$HTTPS_PROXY"

    # Make sure that proxy begin with http or https
    [ -n "$http_proxy"  ] && [ -z "$(echo $http_proxy | grep '^http')"  ] && http_proxy="http://"$http_proxy
    [ -n "$HTTP_PROXY"  ] && [ -z "$(echo $HTTP_PROXY | grep '^http')"  ] && HTTP_PROXY="http://"$HTTP_PROXY
    [ -n "$https_proxy" ] && [ -z "$(echo $https_proxy | grep '^http')" ] && https_proxy="https://"$https_proxy
    [ -n "$HTTPS_PROXY" ] && [ -z "$(echo $HTTPS_PROXY | grep '^http')" ] && HTTPS_PROXY="https://"$HTTPS_PROXY

    # Export
    [ -n "$http_proxy"  ] && env_set http_proxy "$http_proxy"   && INFO "http_proxy set to : $http_proxy"
    [ -n "$HTTP_PROXY"  ] && env_set HTTP_PROXY "$HTTP_PROXY"   && INFO "HTTP_PROXY set to : $HTTP_PROXY"
    [ -n "$https_proxy" ] && env_set https_proxy "$https_proxy" && INFO "https_proxy set to : $https_proxy"
    [ -n "$HTTPS_PROXY" ] && env_set HTTPS_PROXY "$HTTPS_PROXY" && INFO "HTTPS_PROXY set to : $HTTPS_PROXY"

    return 0
}

_set_proxy
unset -f _set_proxy
