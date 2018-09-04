#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Usage: "$0" languagefile file"
fi
while IFS='' read -r line || [[ -n "$line" ]]; do
    grep -n --colour "$line" $2
done < "$1"
