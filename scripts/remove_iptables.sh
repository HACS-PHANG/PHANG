#!/bin/bash

if [[ $# -ne 3 ]]
then
    echo "./remove_iptables.sh [container name] [external ip] [port]"
    exit 1
fi

# Initialize variables
name=$1
ip=$(sudo lxc-info -n $name -iH)
external_ip=$2
port=$3



# Configures nat mappings
sudo ip addr del $external_ip/32 brd + dev enp4s2


# prerouting from external ip to container
sudo iptables --table nat --check PREROUTING --source 0.0.0.0/0 --destination $2 --jump DNAT --to-destination $ip > /dev/null 2> /dev/null

if [ $? -ne 1 ]
then
    sudo iptables --table nat --delete PREROUTING --source 0.0.0.0/0 --destination $2 --jump DNAT --to-destination $ip
fi


# prerouting from external ip to mitm server
sudo iptables --table nat --check PREROUTING --source 0.0.0.0/0 --destination $2 --protocol tcp --dport 22 --jump DNAT --to-destination "127.0.0.1:$port" > /dev/null 2> /dev/null

if [ $? -ne 1 ]
then
    sudo iptables --table nat --delete PREROUTING --source 0.0.0.0/0 --destination $2 --protocol tcp --dport 22 --jump DNAT --to-destination "127.0.0.1:$port"
fi


# postrouting from container to external
sudo iptables --table nat --check POSTROUTING --source $ip --destination 0.0.0.0/0 --jump SNAT --to-source $2 > /dev/null 2> /dev/null

if [ $? -ne 1 ]
then
    sudo iptables --table nat --delete POSTROUTING --source $ip --destination 0.0.0.0/0 --jump SNAT --to-source $2
fi