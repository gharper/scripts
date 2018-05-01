#!/usr/bin/env bash

# Input file in format of <name>=<CIDR>
# ex:
#     daa1r1=10.132.16.0/21
#     dal1r1=10.129.16.0/21

set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace

pids=""

while IFS== read -r region netrange; do
    jumphost="$(echo ${region} | cut -c1-3)8linjump.qa.skytap.com"
    if [[ $(echo ${region} | cut -c4) == '1' ]]; then
        jumphost="$(echo ${region} | cut -c1-3)1linjump.prod.skytap.com"
    fi
    echo "Scanning ${region}: ${netrange} from ${jumphost}"
    sshpass -e ssh ${jumphost} "fping -dug ${netrange} 2>&1 | cut -d' ' -f11- | grep -v skytap | grep ." > "${region}" &
    pids="$pids $!"
done < "${1}"
echo -ne "Waiting on scans to complete... "
wait $pids
echo "done."
