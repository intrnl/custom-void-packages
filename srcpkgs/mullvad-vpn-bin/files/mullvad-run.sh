#!/bin/sh

sv check dbus >/dev/null || exit 1

MULLVAD_RESOURCE_DIR=/opt/Mullvad\ VPN/resources/
exec /usr/bin/mullvad-daemon -v --disable-stdout-timestamps > /dev/null 2>&1
