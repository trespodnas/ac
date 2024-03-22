#!/usr/bin/env sh

IP_FILE='ips.json'
TERRAFORM=`which terraform`
pyCat=`cat ips.json| python -c 'import json,sys;print(json.load(sys.stdin)["vm_private_ips"]["value"])'`
# Clean up
#[ -e $IP_FILE ] && rm -- $IP_FILE && printf "removed existing file (cleanup): $IP_FILE\n"

#for ips in `$pyCat`;do printf $ips;done
echo $pyCat