#!/usr/bin/env bash
# List any gpg keys found in <file2> missing from <file1>

KEYLIST1=$(gpg --no-default-keyring --keyring ${1} --list-keys --with-colons | grep ^pub | awk -F':' '{print $5}' | sort)
KEYLIST2=$(gpg --no-default-keyring --keyring ${2} --list-keys --with-colons | grep ^pub | awk -F':' '{print $5}' | sort)
MISSING=$(echo -e "${KEYLIST2}" | grep -v -F  "${KEYLIST1}")

if [[ -n "$MISSING" ]]; then
    echo -e "${MISSING}"
    exit 1
fi

exit 0
