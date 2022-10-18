#!/bin/bash

file="ext_ip.txt"

shuf $file --output $file

ip1=$(head -n 1 $file)
ip2=$(head -n 2 $file | tail -n 1)
ip3=$(head -n 3 $file | tail -n 1)
ip4=$(head -n 4 $file | tail -n 1)

# recycle all containers and pass in new ip
./cycle.sh $ip1 $ip1 "banner"
./cycle.sh $ip2 $ip2 "banner"
./cycle.sh $ip3 $ip3 "nobanner"
./cycle.sh $ip4 $ip4 "nobanner"