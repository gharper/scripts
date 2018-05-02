#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace

IPLIST=$(cat ${1})

jumphost="$(echo ${1} | cut -c1-3)8linjump.qa.skytap.com"
if [[ $(echo ${1} | cut -c4) == '1' ]]; then
    jumphost="$(echo ${1} | cut -c1-3)1linjump.prod.skytap.com"
fi

for ip in ${IPLIST}; do
    sshpass -e ssh ${jumphost} "dig +short -x ${ip}" 2>&1
done
