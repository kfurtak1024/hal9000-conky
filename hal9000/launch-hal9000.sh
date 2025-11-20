#!/bin/bash

LOCATION=~/.config/conky/hal9000
CONF_FILE=$LOCATION/conky.conf

if [[ -f $CONF_FILE ]]; then
    killall conky &> /dev/null
    cd "$LOCATION" && conky -c "$CONF_FILE" &
else
    echo "Cannot find configuration file: '$CONF_FILE'. Run install.sh first"
    exit 1
fi

