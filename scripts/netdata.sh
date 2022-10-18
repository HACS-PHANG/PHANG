#!/bin/bash
name=$1
sudo lxc-attach -n "$name" -- bash -c "wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh /tmp/netdata-kickstart.sh --claim-token ddJrbLAWUN-NqlFTbAN_3jZgscTP74sFloW1aXflbeohejycqI2kQRq_2cmSvshHX15jzbOb03MSOM6_SMvL5Z4-KP2_SDNnbpUcYAG-jxyE5Bv6hfUyK_sxEsihiRpEVdcQB_4 --claim-url https://app.netdata.cloud"
sudo lxc-attach -n "$name" -- bash -c "cd /etc/netdata/health.d && sed -i 's/warn: $this > (($status >= $WARNING)  ? (75) : (85))/warn: $this > (($status >= $WARNING)  ? (50) : (65))/g' cpu.conf && sudo systemctl restart netdata"
