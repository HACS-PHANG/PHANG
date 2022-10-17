#!/bin/bash

# Initializing these now as arguments but might need to update
container_name=$1
aws_ip=$2
banner_type = $3 # nobanner or banner
timestamp=$(date +%s)
container_name = container_name + timestamp


while :
do
# create new container
./create_container $container_name

# set up ssh
./ssh_setup $container_name

# set up command poisoning
./command_poisoning $container_name

# set up mitm
./iptables_recycle_untested $container_name $aws_ip

# set up banner + honey
if [ $banner_type == "banner" ]
then
./banner $container_name
fi
./honey_set_up $container_name

#Tail on session log
old=$(tail -n 1 /home/student/MITM/logs/session_streams)
while [ old -eq $(tail -n 1 /home/student/MITM/logs/session_streams) ]
do
	sleep 1
end
sudo lxc-attach -n $name -- bash -c "(sudo crontab -l 2>/dev/null; echo '20 * * * * /usr/bin/pkill -KILL -u $user') | sudo crontab -"
(sudo crontab -l 2>/dev/null; echo "*20 * * * * ./remove_attacker $container_name && ./data_upload $container_name && ./count_commands $container_name $banner_type && sudo lxc-stop -n $container_name && sudo lxc-destroy -n $container_name") | sudo crontab -

end
