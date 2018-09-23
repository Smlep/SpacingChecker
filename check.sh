#!/bin/bash

LANGUAGE_DIR='languages/*'

# help option
if [ $1 == '--help' ] || [ $1 == '-h' ]; then
  cat README.md
  exit 2
fi

# show languages option

if [ "$1" == '--languages' -o "$1" == '-l' -o $1 == '--lg' ]; then
  echo "Short names for available languages:"
  for lg_file in $LANGUAGE_DIR
  do
    name_line=$(head -n 1 $lg_file)
    name="${name_line##*: }"

    short_line=$(sed '2q;d' $lg_file)
    short="${short_line##*: }"

    echo $short": "$name
  done
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
    if [ "${line:0:1}" == '#' ] || [ "${#line}" -eq 0 ]; then
      continue
    fi 
    grep -n -E --colour "$line" $2
    if [ $? -ne 1 ]; then
      code=1
    fi
done < "$1"

exit $code
