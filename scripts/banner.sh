#!/bin/bash
if [[ $# -ne 1 ]]
then
  echo "./banner [container name]"
  exit 1
fi
bannertype=$2
if [[ $bannertype == "FBI" ]]
then
  bannertype="by the Federal Bureau of Investigation"
elif [[ $bannertype == "" ]]
then
  bannertype="by the Maryland State Police IT Division"
elif [[ $bannertype == "" ]]
then
  bannertype="by the University of Maryland Department of IT"
fi
#edit motd to display warning message upon login
sudo lxc-attach -n $1 -- bash -c "echo -e '\n\e[31m========================================\n\n WARNING: You are being monitored ${bannertype} \n\n========================================\n\e[0m' > /etc/motd"
