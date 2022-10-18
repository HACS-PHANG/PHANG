#!/bin/bash

# Check arguments
if [[ $# -ne 1 ]]
then
  echo "command_poisoning [container name]"
  exit 1
fi

# Make directory for downloads
sudo lxc-attach -n $1 -- mkdir /var/log/.downloads

# Get paths
wget_path=$(sudo lxc-attach -n $1 -- which wget)
curl_path=$(sudo lxc-attach -n $1 -- which curl)


# Install wget and curl if needed
if [[ ! $wget_path ]]
then
  sudo lxc-attach -n $1 -- sudo apt-get update
  sudo lxc-attach -n $1 -- bash -c "echo 'y' | sudo apt-get install wget"
fi

if [[ ! $curl_path ]]
then
  sudo lxc-attach -n $1 -- sudo apt-get update
  sudo lxc-attach -n $1 -- bash -c "echo 'y' | sudo apt-get install curl"
fi



# Configure wget and curl
wget_path=$(sudo lxc-attach -n $1 -- which wget)
curl_path=$(sudo lxc-attach -n $1 -- which curl)


sudo lxc-attach -n $1 -- mv $wget_path /usr/bin/wget_real
sudo lxc-attach -n $1 -- mv $curl_path /usr/bin/curl_real

sudo lxc-attach -n $1 -- bash -c "echo \#\!/bin/bash >> $wget_path"
sudo lxc-attach -n $1 -- bash -c "echo 'wget_real \"\$@\" -P /var/log/.downloads -q /dev/null 2>&1' >> $wget_path"
sudo lxc-attach -n $1 -- bash -c "echo 'wget_real \"\$@\"' >> $wget_path"
sudo lxc-attach -n $1 -- bash -c "chmod +x $wget_path"

sudo lxc-attach -n $1 -- bash -c "echo \#\!/bin/bash >> $curl_path"
sudo lxc-attach -n $1 -- bash -c "echo 'cd /var/log/.downloads' >> $curl_path"
sudo lxc-attach -n $1 -- bash -c "echo 'curl_real \"\$@\" -q /dev/null 2>&1' >> $curl_path"
sudo lxc-attach -n $1 -- bash -c "echo 'cd -' >> $curl_path"
sudo lxc-attach -n $1 -- bash -c "echo 'curl_real \"\$@\"' >> $curl_path"
sudo lxc-attach -n $1 -- bash -c "chmod +x $curl_path"