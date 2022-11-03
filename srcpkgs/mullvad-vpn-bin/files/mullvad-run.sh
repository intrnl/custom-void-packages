#!/bin/sh

sv check dbus >/dev/null || exit 1

MULLVAD_RESOURCE_DIR=/opt/Mullvad\ VPN/resources/

exec 2>&1
exec /usr/bin/mullvad-daemon -v --disable-stdout-timestamps
