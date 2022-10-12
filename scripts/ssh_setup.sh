#!/bin/bash

# Sets up OpenSSH on the specified container
if [[ $# -ne 1 ]]
then
  echo "./ssh_setup [container name]"
  exit 1
fi

name=$1

# Set up SSH
sudo lxc-attach -n $name -- sudo apt-get update
sudo lxc-attach -n $name -- bash -c "echo 'y' | sudo apt-get install openssh-server"
sudo lxc-attach -n $name -- systemctl start ssh

# Root user login
sudo lxc-attach -n $name -- bash -c "echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config"
sudo lxc-attach -n $name -- systemctl restart ssh
