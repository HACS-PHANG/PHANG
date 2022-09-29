#!/bin/bash


# cleanup + data gathering off of old container

# delete old container

# create new container
./create_container $container_name

# set up ssh
./ssh_setup $container_name

# set up command poisoning
./command_poisoning $container_name

# set up mitm

# set up banner + honey
./banner $container_name