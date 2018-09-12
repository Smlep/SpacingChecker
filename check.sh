#!/bin/bash
if [ $1 == '--help' ]; then
  cat README.md
  exit 2
fi
if [ $# -lt 2 ]; then
  echo "Usage: "$0" language.lg file"
  echo "See $0 --help"
  exit 1
fi
while IFS='' read -r line || [[ -n "$line" ]]; do
    grep -n --colour "$line" $2
done < "$1"
