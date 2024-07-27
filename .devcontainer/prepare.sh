#! /usr/bin/env bash

mkdir -p /run/dbus && \
    chown 1000:1000 /run/dbus

# https://unix.stackexchange.com/questions/473528/how-do-you-enable-the-secret-tool-command-backed-by-gnome-keyring-libsecret-an

# # sudo rm -rf /var/run/dbus/pid
# # dbus-daemon --system --print-address
# sudo service dbus start

# export $(dbus-launch)
# echo "123456" | gnome-keyring-daemon  -r --unlock --components=secrets

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket