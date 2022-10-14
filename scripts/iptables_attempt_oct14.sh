#Call this script from the host w/ container name as arg 1, IP to be used as arg 2
name=$1
ip=$(sudo lxc-info -n $name | grep IP | colrm 1 16)
echo $ip
sudo sysctl -w net.ipv4.conf.all.route_localnet=1
sudo sysctl -w net.ipv4.ip_forward=1

sudo iptables --table nat --insert PREROUTING --source 0.0.0.0/0 --destination "$2" --jump DNAT --to-destination "$ip"
sudo iptables --table nat --insert POSTROUTING --source "$ip" --destination 0.0.0.0/0 --jump SNAT --to-source "$2"
sudo iptables --table nat --insert PREROUTING --source 0.0.0.0/0 --destination "$2" -protocol tcp --dport 22 --jump DNAT --to-destination 127.0.0.1:30
#Install openssh-server on container
sudo lxc-attach -n "$1" -- bash -c "sudo apt-get update -qq && sudo apt-get install
openssh-server -y -qq && sudo systemctl enable ssh && sudo systemctl start ssh"
#Install ACES MITM server on lxc host
git clone https://github.com/UMD-ACES/MITM
cd ./MITM || return
sudo ./install.sh
sudo npm install forever -g
sudo forever -l /home/grace/MITM/"$name".log start /home/grace/MITM/mitm.js -n "$name" -i "$ip" -p 12345 --auto-access --auto-access-fixed 2 --debug

sudo ip addr add "$2"/16 brd + dev enp4s2
sudo iptables --table nat --check PREROUTING --source 0.0.0.0/0 --destination "$2" --jump DNAT --to-destination "$ip" > /dev/null 2> /dev/null
if [ $? -eq 1 ]
then
sudo iptables --table nat --insert PREROUTING --source 0.0.0.0/0 --destination "$2" --jump DNAT --to-destination "$ip"
fi

sudo iptables --table nat --check PREROUTING --source 0.0.0.0/0 --destination "$2" --protocol tcp --dport 22 --jump DNAT --to-destination 127.0.0.1:12345 > /dev/null 2> /dev/null
if [ $? -eq 1 ]
then
sudo iptables --table nat --insert PREROUTING --source 0.0.0.0/0 --destination "$2" --protocol tcp --dport 22 --jump DNAT --to-destination 127.0.0.1:12345

fi

sudo iptables --table nat --check POSTROUTING --source "$ip" --destination 0.0.0.0/0 --jump SNAT --to-source "$2" > /dev/null 2> /dev/null
if [ $? -eq 1 ]
then
sudo iptables --table nat --insert POSTROUTING --source "$ip" --destination 0.0.0.0/0 --jump SNAT --to-source "$2"

fi
