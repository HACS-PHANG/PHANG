#!/bin/bash

# Check if there is one argument
if [[ $# -ne 1 ]]
then
    echo "delete_container [container name]"
    exit 1
fi    

name=$1

# Create and Start Container
sudo lxc-stop -n $name 
sudo lxc-destroy -n $name
