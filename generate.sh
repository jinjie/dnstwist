#!/bin/bash

DNSTWIST_BIN=`which dnstwist`
BASE_DIR=$( dirname "${BASH_SOURCE[0]}" )
DATA_DIR="${BASE_DIR}/data"


# Checks if dnstwist are installed
if [ "$?" -ne "0" ];
then
    echo "ERROR: Install dnstwist first: https://github.com/elceef/dnstwist"
    exit 1
fi

# Clear social-twisted-dns file
echo -n > "${BASE_DIR}/social-twisted-dns"

cat ${DATA_DIR}/seed_domains.txt | sort | while read domain
do
    echo "Twisting ${domain}..."
    $DNSTWIST_BIN -f csv $domain | sed '1d' | grep -v '^original' | cut -d "," -f 2 >> social-twisted-dns
done

echo "Done"
exit 0
