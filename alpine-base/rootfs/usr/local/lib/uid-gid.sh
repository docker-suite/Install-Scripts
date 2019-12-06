#!/usr/bin/env bash

# Add libraries
source /usr/local/lib/bash-logger.sh

# Change user UID
# Eg: set_uid 1000 "${MY_USER}" "/home/${MY_USER}" "${DEBUG_LEVEL}"
#----------------------------------------------------------------------------------------------------------------------
set_uid() {
    if [ $# -lt 3 ]; then
        return 1
    fi

	local uid="${1}"
	local username="${2}"
	local homedir="${3}"

	local spare_uid=9876	# spare uid to change another user to

    if ! isint "${uid}"; then
        ERROR "\$'${uid}' is not an integer"
        exit 1
    else
        # Username with this uid already exists
        if target_username="$( getusernamebyuid "${uid}" )"; then
            # It is not our user, so we need to changes his/her uid to something else first
            if [ "${target_username}" != "${username}" ]; then
                WARNING "User with ${uid} already exists: ${target_username}"
                INFO "Changing UID of ${target_username} to ${spare_uid}"
                LOG_RUN "usermod -u ${spare_uid} ${target_username}"
            fi
        fi
        # Change uid and fix homedir permissions
        INFO "Changing user '${username}' uid to: ${uid}"
        LOG_RUN "usermod -u ${uid} ${username}"
        LOG_RUN "chown -R ${username} ${homedir}"
    fi
}

# Change group GID
# Eg: set_gid 1000 "${MY_GROUP}" "/home/${MY_USER}" "${DEBUG_LEVEL}"
#----------------------------------------------------------------------------------------------------------------------
set_gid() {
    if [ $# -lt 3 ]; then
        return 1
    fi

	local gid="${1}"
	local groupname="${2}"
	local homedir="${3}"

	local spare_gid=9876	# spare gid to change another group to

    if ! isint "${gid}"; then
        ERROR "\$'${gid}' is not an integer"
        exit 1
    else
        # Groupname with this gid already exists
        if target_groupname="$( getgroupnamebygid "${gid}" )"; then
            # It is not our group, so we need to changes his/her gid to something else first
            if [ "${target_groupname}" != "${groupname}" ]; then
                WARNING "Group with ${gid} already exists: ${target_groupname}"
                INFO "Changing GID of ${target_groupname} to ${spare_gid}"
                LOG_RUN "groupmod -g ${spare_gid} ${target_groupname}"
            fi
        fi
        # Change ugd and fix homedir permissions
        INFO "Changing group '${groupname}' gid to: ${gid}"
        LOG_RUN "groupmod -g ${gid} ${groupname}"
        LOG_RUN "chown -R :${groupname} ${homedir}"
     fi
}

