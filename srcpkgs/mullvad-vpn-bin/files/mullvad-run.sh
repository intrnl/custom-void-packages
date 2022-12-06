#!/bin/sh

sv check dbus >/dev/null || exit 1

# make mullvad-exclude actually work properly by creating the responsible file
# ahead of time with the correct permissions
mkdir -p /sys/fs/cgroup/net_cls/mullvad-exclusions/
touch /sys/fs/cgroup/net_cls/mullvad-exclusions/cgroup.procs
chmod 777 /sys/fs/cgroup/net_cls/mullvad-exclusions/cgroup.procs

MULLVAD_RESOURCE_DIR=/opt/Mullvad\ VPN/resources/
exec /usr/bin/mullvad-daemon -v --disable-stdout-timestamps > /dev/null 2>&1
