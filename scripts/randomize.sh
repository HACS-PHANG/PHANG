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

timestamp=$(date +%s)
cont1="${container_name_1}${timestamp}"
cont2="${container_name_2}${timestamp}"
cont3="${container_name_3}${timestamp}"
cont4="${container_name_4}${timestamp}"
cont5="${container_name_5}${timestamp}"

# recycle all containers and pass in new ip
./cycle.sh $ip1 $ip1 "FBI"
#"by the Federal Bureau of Investigations"
./cycle.sh $ip2 $ip2 "MarylandPolice" 
#"by the Maryland State Police IT Division" 
./cycle.sh $ip3 $ip3 "UMD_IT" 
#"by the University of Maryland Department of IT" 
./cycle.sh $ip4 $ip4 "NoEntity" 
./cycle.sh $ip5 $ip5 "nobanner"

sleep 5m
# Cleaning up iptables + container <-- need to move based on what's calling cycle.sh
./remove_iptables $cont1 $ip1 $port1
sudo cp -r /var/lib/lxc/$cont1/rootfs/var/log/.downloads /home/student/$banner_type/$cont1/downloads
sudo lxc-stop -n $cont1
sudo lxc-destroy -n $cont1

# Cleaning up iptables + container <-- need to move based on what's calling cycle.sh
./remove_iptables $cont2 $ip2 $port2
sudo cp -r /var/lib/lxc/$cont2/rootfs/var/log/.downloads /home/student/$banner_type/$cont2/downloads
sudo lxc-stop -n $cont2
sudo lxc-destroy -n $cont2

# Cleaning up iptables + container <-- need to move based on what's calling cycle.sh
./remove_iptables $cont3 $ip3 $port3
sudo cp -r /var/lib/lxc/$cont3/rootfs/var/log/.downloads /home/student/$banner_type/$cont3/downloads
sudo lxc-stop -n $cont3
sudo lxc-destroy -n $cont3

# Cleaning up iptables + container <-- need to move based on what's calling cycle.sh
./remove_iptables $cont4 $ip4 $port4
sudo cp -r /var/lib/lxc/$cont4/rootfs/var/log/.downloads /home/student/$banner_type/$cont4/downloads
sudo lxc-stop -n $cont4
sudo lxc-destroy -n $cont4

# Cleaning up iptables + container <-- need to move based on what's calling cycle.sh
./remove_iptables $cont5 $ip5 $port5
sudo cp -r /var/lib/lxc/$cont5/rootfs/var/log/.downloads /home/student/$banner_type/$cont5/downloads
sudo lxc-stop -n $cont5
sudo lxc-destroy -n $cont5
