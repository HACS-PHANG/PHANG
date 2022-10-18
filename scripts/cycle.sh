#!/bin/bash
# Initializing these now as arguments but might need to update
container_name=$1
ext_ip=$2
banner_type=$3 # nobanner or banner
timestamp=$(date +%s)
container_name="${container_name}${timestamp}"
ips_file="ext_ip.txt"
#cd /home/student/PHANG/scripts



# we need to add deleting container and data upload


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
./working_iptables.sh $container_name $ext_ip 12345 $banner_type
echo "================================================= end of working iptables"


# set up banner + honey
if [ $banner_type == "banner" ]
then
./banner.sh $container_name
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


