#!/bin/bash
if [[ $# -ne 1 ]]
then
  echo "./banner [container name]"
  exit 1
fi
bannertype=$2
#edit motd to display warning message upon login
sudo lxc-attach -n $1 -- bash -c "echo -e '\n\e[31m========================================\n\n WARNING: You are being monitored ${bannertype} \n\n========================================\n\e[0m' > /etc/motd"
