#!/bin/bash

# CONFIG
RUN_ID=$1                       
REPO="Arison7/zmk-config"                  # your GitHub repo
DIR="$./firmware"                  # folder to save UF2s


if [[ ! $RUN_ID]]; then
    echo "Please provide run id of the action."
    exit 1
fi

# make sure the directory exists
mkdir -p "$DIR"

# loop until download succeeds
while true; do
    echo "Attempting to download artifacts..."
    
    gh run download "$RUN_ID" --repo "$REPO" --dir "$DIR"
    STATUS=$?
    
    if [ $STATUS -eq 0 ]; then
        echo "Download succeeded! UF2 files are in $DIR"
        break
    else
        echo "Download failed. Retrying in 10 seconds..."
        sleep 10
    fi
done
