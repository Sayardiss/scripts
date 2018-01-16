#!/bin/bash
# guake-start.sh
/usr/bin/guake &
sleep 2
guake --rename-tab="home" &
sleep 1
guake --new-tab=2 --rename-tab="OpenVPN" --execute-command="sudo openvpn /home/user/krammercert.ovpn"
