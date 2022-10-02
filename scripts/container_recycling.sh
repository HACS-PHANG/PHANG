#!/bin/bash

# Initializing this now as an argument but might need to update
container_name=$1

# cleanup + data gathering off of old container
./data_upload $container_name

# delete old container
lxc-destroy -n $container_name

# create new container
./create_container $container_name

# set up ssh
./ssh_setup $container_name

# set up command poisoning
./command_poisoning $container_name

# set up mitm

# set up banner + honey
./banner $container_name