#!/usr/bin/env bash
#
# Purpose: To help find unused IP addresses for VIP allocation
#
# Use: ~/git/scripts/find_open_ips.sh ~/tmp/finding_ips/mgt_networks
#
# Input file in format of <name>=<CIDR>
# ex:
#     daa1r1=10.132.16.0/21
#     dal1r1=10.129.16.0/21

set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace # For debugging

pids=""
if [[ -z $SSHPASS ]]; then
    echo "export SSHPASS='<your passwd>'"
    exit 1
fi

while IFS== read -r region netrange; do
    jumphost="$(echo ${region} | cut -c1-3)8linjump.qa.skytap.com"
    if [[ $(echo ${region} | cut -c1) == '#' ]]; then
        continue
    fi
    if [[ $(echo ${region} | cut -c1-3) == 'sea' ]]; then
        jumphost="tuk8linjump.qa.skytap.com"
    fi
    if [[ $(echo ${region} | cut -c4) == '1' ]]; then
        #jumphost="$(echo ${region} | cut -c1-3)1linjump.prod.skytap.com"
        jumphost="tuk1linjump.prod.skytap.com"
    fi
    echo "Scanning ${region}: ${netrange} from ${jumphost}"

    # fping -dug: Use DNS to lookup address, show unreachable addresses, generate range from addr/mask
    # cut -d' ' -f11-: print only the IP address and/or DNS name
    # grep -v skytap: remove any lines with a DNS entry
    # grep .: remove blank lines
    # End result should be a list of addresses that didn't ping and aren't in DNS
    sshpass -e ssh ${jumphost} "fping -dug ${netrange} 2>&1 | cut -d' ' -f11- | grep -v skytap | grep ." > "${region}.out" &
    pids="$pids $!"
done < "${1}"
echo -ne "Waiting on scans to complete... "
wait $pids
echo "done."
