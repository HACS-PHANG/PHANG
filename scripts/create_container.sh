#!/bin/bash

# Check if there is one argument
if [[ $# -ne 1 ]]
then
    echo "create_container [container name]"
    exit 1
fi    

name=$1

# Create and Start Container
sudo lxc-create -n $name -t download -- -d ubuntu -r focal -a amd64
sudo lxc-start -n $name
