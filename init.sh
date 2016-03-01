#!/bin/sh

#
# Script options (exit script on command fail).
#
set -e

#
# Define default Variables.
#
USER="homeassistant"
GROUP="homeassistant"
COMMAND_OPTIONS_DEFAULT=""
UID_DEFAULT="666"
GID_DEFAULT="666"
COMMAND="hass --open-ui  ${COMMAND_OPTIONS:=${COMMAND_OPTIONS_DEFAULT}}"

UID_ACTUAL=$(id -u ${USER})
GID_ACTUAL=$(id -g ${GROUP})

#
# Display settings on standard out.
#
echo "container settings"
echo "=================="
echo
echo "  Username:        ${USER}"
echo "  Groupname:       ${GROUP}"
echo "  UID actual:      ${UID_ACTUAL}"
echo "  GID actual:      ${GID_ACTUAL}"
echo "  UID prefered:    ${UID:=${UID_DEFAULT}}"
echo "  GID prefered:    ${GID:=${GID_DEFAULT}}"
echo "  Command:         ${COMMAND}"
echo

#
# Change UID / GID of user.
#
echo "Updating UID / GID... "
if [[ ${GID_ACTUAL} -ne ${GID} -o ${UID_ACTUAL} -ne ${UID} ]]
then
    echo "change user / group"
    deluser ${USER}
    addgroup -g ${GID} ${GROUP}
    adduser -u ${UID} -G ${GROUP} -h /etc/bind -g "${USER} User" -s /bin/sh -D ${USER}
    echo "[DONE]"
    echo "Set owner and permissions for old uid/gid files"
    find / -user ${UID_ACTUAL} -exec chown ${USER} {} \;
    find / -group ${GID_ACTUAL} -exec chgrp ${GROUP} {} \;
    echo "[DONE]"
else
    echo "[NOTHING DONE]"
fi

#
# Set owner and permissions.
#
echo "Set owner and permissions... "
chown -R ${USER}:${GROUP} /home/${USER}
chmod -R o-rwx /home/${USER}
echo "[DONE]"

#
# Start application.
#
echo "Start application... "
exec ${COMMAND}
