#Add attacker's ip to iptables
atkip= $(sudo lxc-attach -n $name -- bash -c "who | head -n 1 | awk '{ print $5 }'")
sudo lxc-attach -n $name -- bash -c "iptables -I INPUT -s $1 -j DROP"

#Save iptables on container's filesystem
sudo lxc-attach -n $name -- bash -c "/sbin/iptables-save > /etc/iptables/rules.v4"
#Access container's filesystem from host & append to host log
cat /var/lib/lxc/$name/rootfs/etc/iptables/rules.v4 >> ip_rules_$name.log
