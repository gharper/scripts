#!/usr/bin/env bash
# Find an ip with a common octet from multiple lists of addresses
# Use after running find_open_ips.sh
#
# Purpose: Find an ip with a common octet from multiple lists of addresses
# Use after runnfind_open_ips.sh
#
# Use: ~/git/scripts/find_common_ips.sh <filename pattern>

set -o pipefail
set -o nounset
#set -o xtrace

for ((octet=1;octet<=255;octet++)); do
    regex="\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){3}${octet}\b"
    skip_address=$(egrep -L "$regex" *.out 2>&1)
    if [[ -z ${skip_address} ]]; then
        echo "xxx.xxx.xxx.${octet}"
    fi
done

# To get a list of regions & the desired ip:
# ${octet} = chosen ending octet
# ls -1 *.out | xargs -I {} egrep -H "\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){3}${octet}\b" {} | sort -u -t":" -k1,1|sed 's/\.out//;s/:/ /'
# to format as confluence table, add
# | awk '{gsub(/.out/, "")} {print "|" $1 "|" $1 "netadminvip1.mgt.prod.skytap.com" "|" $2 "|"}'

