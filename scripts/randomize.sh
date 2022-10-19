#!/bin/bash

file="ext_ip.txt"

shuf $file --output $file

ip1=$(head -n 1 $file)
ip2=$(head -n 2 $file | tail -n 1)
ip3=$(head -n 3 $file | tail -n 1)
ip4=$(head -n 4 $file | tail -n 1)
ip5=$(head -n 5 $file | tail -n 1)

port1=12345
port2=12344
port3=12343
port4=12346
port5=12347

container_name_1="cont1"
container_name_2="cont2"
container_name_3="cont3"
container_name_4="cont4"
container_name_5="cont5"

timestamp=$(date +"%Y-%m-%d-%T")
cont1="${container_name_1}${timestamp}"
cont2="${container_name_2}${timestamp}"
cont3="${container_name_3}${timestamp}"
cont4="${container_name_4}${timestamp}"
cont5="${container_name_5}${timestamp}"

banner1="FBI"
banner2="MarylandPolice"
banner3="UMD_IT"
banner4="NoEntity"
banner5="NoBanner"
echo $ip1
# recycle all containers and pass in new ip
./cycle.sh $cont1 $ip1 $banner1 $port1
#"by the Federal Bureau of Investigations"
#./cycle.sh $cont2 $ip2 $banner2 $port2
#"by the Maryland State Police IT Division" 
#./cycle.sh $cont3 $ip3 $banner3 $port3
#"by the University of Maryland Department of IT" 
#./cycle.sh $cont4 $ip4 $banner4 $port4
#./cycle.sh $cont5 $ip5 $banner5 $port5

sleep 5m
# Cleaning up iptables + container <-- need to move based on what's calling cycle.sh
./remove_iptables.sh $cont1 $ip1 $port1
sudo cp -r /var/lib/lxc/$cont1/rootfs/var/log/.downloads /home/student/$banner1/$cont1/downloads
./data_collection/count_commands.sh $cont1 $banner1
sudo lxc-stop -n $cont1
sudo lxc-destroy -n $cont1

# Cleaning up iptables + container <-- need to move based on what's calling cycle.sh
#./remove_iptables $cont2 $ip2 $port2
#./data_collection/count_commands $cont2 $banner_2
#sudo cp -r /var/lib/lxc/$cont2/rootfs/var/log/.downloads /home/student/$banner2/$cont2/downloads
#sudo lxc-stop -n $cont2
#sudo lxc-destroy -n $cont2

# Cleaning up iptables + container <-- need to move based on what's calling cycle.sh
#./remove_iptables $cont3 $ip3 $port3
#./data_collection/count_commands $cont3 $banner3
#sudo cp -r /var/lib/lxc/$cont3/rootfs/var/log/.downloads /home/student/$banner3/$cont3/downloads
#sudo lxc-stop -n $cont3
#sudo lxc-destroy -n $cont3

# Cleaning up iptables + container <-- need to move based on what's calling cycle.sh
#./remove_iptables $cont4 $ip4 $port4
#./data_collection/count_commands $cont4 $banner4
#sudo cp -r /var/lib/lxc/$cont4/rootfs/var/log/.downloads /home/student/$banner4/$cont4/downloads
#sudo lxc-stop -n $cont4
#sudo lxc-destroy -n $cont4

# Cleaning up iptables + container <-- need to move based on what's calling cycle.sh
#./remove_iptables $cont5 $ip5 $port5
#./data_collection/count_commands $cont5 $banner5
#sudo cp -r /var/lib/lxc/$cont5/rootfs/var/log/.downloads /home/student/$banner5/$cont5/downloads
#sudo lxc-stop -n $cont5
#sudo lxc-destroy -n $cont5
