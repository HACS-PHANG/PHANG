#!/bin/bash

# Initializing these now as arguments but might need to update
container_name=$1
aws_ip=$2

# remove attacker
./remove_attacker $container_name

# cleanup + data gathering off of old container
./data_upload $container_name

# delete old container
lxc-stop -n $container_name
lxc-destroy -n $container_name

# create new container
./create_container $container_name

# set up ssh
./ssh_setup $container_name

# set up command poisoning
./command_poisoning $container_name

# set up mitm
./iptables_recycle_untested $container_name $aws_ip

# set up banner + honey
./banner $container_name
./honey_set_up $container_name
