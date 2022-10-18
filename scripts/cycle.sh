#!/bin/bash

# Checking args first
if [[ $# -ne 4 ]]
then
    echo "./cycle.sh [container name] [external ip] [banner type] [port]"
    exit 1
fi

# Initializing these now as arguments but might need to update
container_name=$1
ext_ip=$2
banner_type=$3 # nobanner or banner
port=$4
#container_name="${container_name_init}${timestamp}"
#cd /home/student/PHANG/scripts <-- need to figure out

# create new container
mkdir /home/student/$banner_type/$container_name
./create_container.sh $container_name
sleep 5
echo "==============================================end of create container"

# set up ssh
./ssh_setup.sh $container_name
echo "=============================================== end of ssh setup"

# set up command poisoning
./command_poisoning.sh $container_name
echo "============================================end of command poisoning"

# set up mitm
./working_iptables.sh $container_name $ext_ip $port $banner_type
echo "================================================= end of working iptables"


# set up banner + honey
if [ $banner_type != "NoBanner" ]
then
./banner.sh $container_name $banner_type
fi
./honey_set_up.sh $container_name
echo "Success"


#Tail on session log
#old=$(tail -n 1 /home/student/$bannertype/$name/$name.log)
#while [[ old == $(tail -n 1 /home/student/$bannertype/$name/$name.log) ]]
#do
#	sleep 1
#done
#sudo lxc-attach -n $name -- bash -c "(sudo crontab -l 2>/dev/null; echo '20 * * * * /usr/bin/pkill -KILL -u $user') | sudo crontab -"
#(sudo crontab -l 2>/dev/null; echo "*20 * * * * ./remove_attacker $container_name && ./data_upload $container_name && ./count_commands $container_name $banner_type && sudo lxc-stop -n $container_name && sudo lxc-destroy -n $container_name && ./cycle.sh $name 128.8.238.32 $banner_type") | sudo crontab -e

# Cleaning up iptables + container <-- need to move based on what's calling cycle.sh
#./remove_iptables $container_name $ext_ip $port
#sudo cp -r /var/lib/lxc/$name/rootfs/var/log/.downloads /home/student/$banner_type/$name/downloads
#sudo lxc-stop -n $container_name
#sudo lxc-destroy -n $container_name
