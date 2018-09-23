#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
LANGUAGE_DIR=$DIR'/languages/*'

# good parameters number
if [ $# -lt 1 ]; then
  echo "Usage: "$0" language.lg file"
  echo "See $0 --help"
  exit 1
fi

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

language_file='error'
ext=$(echo "$1" | sed 's/.*\(...\)/\1/')
echo "Looking for a language file..."
if [ $ext == '.lg' ]; then
  language_file=$1
  if [ -f $1 ]; then
    echo "Loading $1"
  else
    echo "$1 does not exist"
    exit 1
  fi
else
  echo "Searching files corresponding to $1"
  for lg_file in $LANGUAGE_DIR
  do  
    name_line=$(head -n 1 $lg_file)
    name="${name_line##*: }"

    short_line=$(sed '2q;d' $lg_file)
    short="${short_line##*: }"
    
    if [ $short == $1 ]; then
      language_file=$lg_file
      echo "Loading $name"
      break
    fi
  done
  if [ $language_file == 'error' ]; then
    echo "No language file were found"
    exit 1
  fi
fi

# language file extension
ext=$(echo "$language_file" | sed 's/.*\(...\)/\1/')
if [ $ext != '.lg' ]; then
  echo "Bad language file extension"
  echo "Expected: .lg"
  echo "Has: "$ext
  exit 1
fi

if [ -z "$(tail -c 2 "$language_file")" ]; then
  echo "Language file contains an empty line"
  exit 1
fi

# file to check existence
if [ ! -f $2 ]; then
  echo "$2 does not exist"
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
done < "$language_file"

exit $code
