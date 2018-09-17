#!/bin/bash

# help option
if [ $1 == '--help' ]; then
  cat README.md
  exit 2
fi

# good parameters number
if [ $# -lt 2 ]; then
  echo "Usage: "$0" language.lg file"
  echo "See $0 --help"
  exit 1
fi

# language file existence
if [ ! -f $1 ]; then
  echo "$1 does not exist"
  exit 1
fi

# file to check existence
if [ ! -f $2 ]; then
  echo "$2 does not exist"
  exit 1
fi

# language file extension
ext=$(echo "$1" | sed 's/.*\(...\)/\1/')
if [ $ext != '.lg' ]; then
  echo "Bad language file extension"
  echo "Expected: .lg"
  echo "Has: "$ext
  exit 1
fi

if [ -z "$(tail -c 2 "$1")" ]; then
  echo "Language file contains an empty line"
  exit 1
fi

code=0

# file checking
while IFS='' read -r line || [[ -n "$line" ]]; do
    grep -n -E --colour "$line" $2
    if [ $? -ne 1 ]; then
      code=1
    fi
done < "$1"

exit $code
