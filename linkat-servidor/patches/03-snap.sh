#!/bin/bash

apparmorLink="/etc/apparmor.d/disable/usr.lib.snapd.snap-confine.real"

if [[ -e $apparmorLink ]]; then
        exit 1;
else
        sudo ln -s /etc/apparmor.d/usr.lib.snapd.snap-confine.real /etc/apparmor.d/disable/
        sudo apparmor_parser -R /etc/apparmor.d/usr.lib.snapd.snap-confine.real
        sudo systemctl restart snapd
fi

