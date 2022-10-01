#Add attacker's ip to iptables
atkip= $(who | head -n 1 | awk '{ print $5 }')
iptables -I INPUT -s $1 -j DROP
#Crontab to remove attacker's connection after 20 mins
sudo lxc-attach -n $name -- bash -c "sudo crontab -e && 1 && */20 * * * * pkill -KILL -u $user" 

#Save iptables on container's filesystem
sudo /sbin/iptables-save > /etc/iptables/rules.v4
#Access container's filesystem from host & save 
cp /var/lib/lxc/$name/rootfs/etc/iptables/rules.v4 ip_rules_$name.log
#Destroy container
lxc-destroy-n $name
