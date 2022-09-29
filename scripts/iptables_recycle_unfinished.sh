#Call this script from the host w/ container name as arg 1, IP to be used as arg 2
name=$1

ip=$(lxc-info -n $name | grep IP | colrm 1 16)

forever -l /home/student/MITM/$name.log start /home/student/MITM/mitm.js -n $name -i
$ip -p 12345 --auto-access --auto-access-fixed 2 --debug

ip addr add $2/16 brd + dev enp4s2
iptables --table nat --check PREROUTING --source 0.0.0.0/0 --destination $2 --jump
DNAT --to-destination $ip > /dev/null 2> /dev/null
if [ $? -eq 1 ]
then
iptables --table nat --insert PREROUTING --source 0.0.0.0/0 --destination $2
--jump DNAT --to-destination $ip
fi

iptables --table nat --check PREROUTING --source 0.0.0.0/0 --destination $2
--protocol tcp --dport 22 --jump DNAT --to-destination 127.0.0.1:12345 >
/dev/null 2> /dev/null
if [ $? -eq 1 ]
then
iptables --table nat --insert PREROUTING --source 0.0.0.0/0 --destination $2
--protocol tcp --dport 22 --jump DNAT --to-destination 127.0.0.1:12345
fi

iptables --table nat --check POSTROUTING --source $ip --destination 0.0.0.0/0 --jump
SNAT --to-source $2 > /dev/null 2> /dev/null
if [ $? -eq 1 ]
then
iptables --table nat --insert POSTROUTING --source $ip --destination 0.0.0.0/0
--jump SNAT --to-source $2
fi

#Edit sshd_config to allow root login and block multiple connections
sudo lxc-attach -n "$1" -- bash -c "cd /etc/ssh && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' sshd_config && sed -i 's/#MaxSessions/MaxSessions 1/g' sshd_config && sed -i 's/#MaxStartups/MaxStartups 1/g' sshd_config && sudo systemctl restart ssh.service"