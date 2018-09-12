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

code=0

while IFS='' read -r line || [[ -n "$line" ]]; do
    grep -n --colour "$line" $2
    if [ $? -ne 1 ]; then
      code=1
    fi
done < "$1"

exit $code
