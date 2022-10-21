#!/bin/bash
if [[ $# -ne 2 ]]
then
  echo "./banner [container name] [banner type]"
  exit 1
fi
bannertype=$2
if [[ $bannertype == "FBI" ]]
then
  bannertype="by the Federal Bureau of Investigation"
elif [[ $bannertype == "MarylandPolice" ]]
then
  bannertype="by the Maryland State Police IT Division"
elif [[ $bannertype == "NoEntity" ]]
then
 bannertype="" 
elif [[ $bannertype == "UMD_IT" ]]
then
  bannertype="by the University of Maryland Department of IT"
fi
#edit motd to display warning message upon login
sudo lxc-attach -n $1 -- bash -c "echo -e '\n\e[31m=====================================================================\n\n WARNING: You are being monitored ${bannertype} \n\n=====================================================================\n\e[0m' > /etc/motd"
