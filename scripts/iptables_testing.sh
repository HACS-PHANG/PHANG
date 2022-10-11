#!/bin/bash

if [[ $# -ne 2 ]]
then
    echo "./iptables_recycle.sh [container name] [external ip]"
    exit 1
fi

# Initialize variables
name=$1
ip=$(sudo lxc-info -n $name -iH)
external_ip=$2
port=12345
log_folder="mitm_logs"

# Starts background mitm server
sudo forever -l /home/helen/scripts/MITM/$log_folder/$name.log --append start /home/helen/scripts/MITM/mitm.js -n $name -i $ip -p $port --auto-access --auto-access-fixed 3 --debug


# Configures nat mappings
sudo ip addr add $external_ip/32 brd + dev enp4s2


# prerouting from external ip to container
sudo iptables --table nat --check PREROUTING --source 0.0.0.0/0 --destination $2 --jump DNAT --to-destination $ip > /dev/null 2> /dev/null

if [ $? -eq 1 ]
then
    sudo iptables --table nat --insert PREROUTING --source 0.0.0.0/0 --destination $2 --jump DNAT --to-destination $ip
fi


# prerouting from external ip to mitm server
sudo iptables --table nat --check PREROUTING --source 0.0.0.0/0 --destination $2 --protocol tcp --dport 22 --jump DNAT --to-destination "172.30.141.235:$port" > /dev/null 2> /dev/null

if [ $? -eq 1 ]
then
    sudo iptables --table nat --insert PREROUTING --source 0.0.0.0/0 --destination $2 --protocol tcp --dport 22 --jump DNAT --to-destination "172.30.141.235:$port"
fi


# postrouting from container to external
sudo iptables --table nat --check POSTROUTING --source $ip --destination 0.0.0.0/0 --jump SNAT --to-source $2 > /dev/null 2> /dev/null

if [ $? -eq 1 ]
then
    sudo iptables --table nat --insert POSTROUTING --source $ip --destination 0.0.0.0/0 --jump SNAT --to-source $2
fi

#Copy iptables rules from prev. cycle into container and restore
cp ip_rules_$name.log /var/lib/lxc/$name/rootfs/etc/iptables/rules.v4
sudo lxc-attach -n $name -- bash -c "sudo /sbin/iptables-restore < /etc/iptables/rules.v4"

#Edit sshd_config to allow root login and block multiple connections
sudo lxc-attach -n "$1" -- bash -c "cd /etc/ssh && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' sshd_config && sed -i 's/#MaxSessions 10/MaxSessions 1/g' sshd_config && sed -i 's/#MaxStartups 6/MaxStartups 1/g' sshd_config && sudo systemctl restart ssh.service"

#Crontab to remove attacker's connection after 20 mins
sudo lxc-attach -n $name -- bash -c "sudo crontab -e && 1 && */20 * * * * pkill -KILL -u $user"
