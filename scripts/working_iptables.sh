#!/bin/bash

if [[ $# -ne 4 ]]
then
    echo "./iptables_recycle.sh [container name] [external ip] [port] [bannertype]"
    exit 1
fi

# Initialize variables
name=$1
ip=$(sudo lxc-info -n $name -iH)
external_ip=$2
port=$3
bannertype=$4 #will either be "nobanner" or "banner"
mitm_path="/home/student/$bannertype/$name"

sudo ip link set enp4s2 up
sudo sysctl -w net.ipv4.conf.all.route_localnet=1
sudo sysctl -w net.ipv4.ip_forward=1



# Starts background mitm server
sudo forever -l $mitm_path/$name.log --append start /home/student/MITM/mitm.js -n $name -i $ip -p $port --auto-access --auto-access-fixed 3 --debug
#anything with .log is an mitm log.

# Configures nat mappings
sudo ip addr add $external_ip/32 brd + dev enp4s2



# prerouting from external ip to container
sudo iptables --table nat --check PREROUTING --source 0.0.0.0/0 --destination $2 --jump DNAT --to-destination $ip > /dev/null 2> /dev/null

if [ $? -eq 1 ]
then
    sudo iptables --table nat --insert PREROUTING --source 0.0.0.0/0 --destination $2 --jump DNAT --to-destination $ip
fi


# prerouting from external ip to mitm server
sudo iptables --table nat --check PREROUTING --source 0.0.0.0/0 --destination $2 --protocol tcp --dport 22 --jump DNAT --to-destination "127.0.0.1:$port" > /dev/null 2> /dev/null

if [ $? -eq 1 ]
then
    sudo iptables --table nat --insert PREROUTING --source 0.0.0.0/0 --destination $2 --protocol tcp --dport 22 --jump DNAT --to-destination "127.0.0.1:$port"
fi


# postrouting from container to external
sudo iptables --table nat --check POSTROUTING --source $ip --destination 0.0.0.0/0 --jump SNAT --to-source $2 > /dev/null 2> /dev/null

if [ $? -eq 1 ]
then
    sudo iptables --table nat --insert POSTROUTING --source $ip --destination 0.0.0.0/0 --jump SNAT --to-source $2
fi
