#!/bin/bash
if [[ $# -ne 1 ]]
then
  echo "./banner [container name]"
  exit 1
fi

#edit motd to display warning message upon login
sudo lxc-attach -n $1 -- bash -c "echo -e 'message' > /etc/motd"