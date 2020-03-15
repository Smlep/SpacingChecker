#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

LANGUAGE_DIR=$DIR'/languages/*'

help_opt(){
  cat "$DIR/README.md" || cat "$DIR/../README.md"
  exit 2
}

usage_error(){
  echo "Usage: $0 language.lg file"
  echo "See $0 --help"
  exit 3
}

# show languages option
language_help(){
  echo "Short names for available languages:"
  for lg_file in $LANGUAGE_DIR
  do
    name_line=$(head -n 1 "$lg_file")
    name="${name_line##*: }"

    short_line=$(sed '2q;d' "$lg_file")
    short="${short_line##*: }"

    echo "$short: $name"
  done
  exit 2
}


find_language_file(){
  language_file='error'
  ext=$(echo "$1" | sed 's/.*\(...\)/\1/')
  echo "Looking for a language file..."
  if [ "$ext" == '.lg' ]; then
    language_file=$1
    if [ -f "$1" ]; then
      echo "Loading $1"
    else
      echo "$1 does not exist"
      exit 3
    fi
  else
    echo "Searching files corresponding to $1"
    for lg_file in $LANGUAGE_DIR
    do
      name_line=$(head -n 1 "$lg_file")
      name="${name_line##*: }"

      short_line=$(sed '2q;d' "$lg_file")
      short="${short_line##*: }"

      if [ "$short" == "$1" ]; then
        language_file=$lg_file
        echo "Loading $name"
        break
      fi
    done
    if [ "$language_file" == 'error' ]; then
      echo "No language file were found"
      exit 3
    fi
  fi

  ext=$(echo "$language_file" | sed 's/.*\(...\)/\1/')
  if [ "$ext" != '.lg' ]; then
    echo "Bad language file extension"
    echo "Expected: .lg"
    echo "Has: $ext"
    exit 3
  fi

  used_lg_file=$language_file
}

check_file(){
  echo
  echo "Checking $2:"
  count=0

  while IFS='' read -r line || [[ -n "$line" ]]; do
    if [ "${line:0:1}" == '#' ] || [ "${#line}" -eq 0 ]; then
      continue
    fi
    grep -n -E --colour "$line" "$2"
    count=$((count + $(grep -c -E "$line" "$2")))
  done < "$1"
  echo
  if [ $count -eq 0 ]; then
    echo "No error found in $2"
    return 0
  elif [ $count -eq 1 ]; then
    echo "1 error found in $2"
    return 1
  else
    echo "$count errors found in $2"
    return 1
  fi
}

POSITIONAL=()
HELP=0
LANGUAGE_HELP=0
SILENT=0

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -h|--help)
    HELP=1
    shift # past argument
    ;;
    -l|--lg|--languages)
    LANGUAGE_HELP=1
    shift # past argument
    ;;
    -s|--silent)
    SILENT=1
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters


if [ $SILENT -ne 0 ]; then
  exec 1>/dev/null
fi
# help option
if [ $HELP -ne 0 ]; then
  help_opt
fi

if [ $LANGUAGE_HELP -ne 0 ]; then
  language_help
fi

# good parameter count
if [ $# -lt 2 ]; then
  usage_error
fi

# file to check existence
if [ ! -f "$2" ]; then
  echo "$2 does not exist"
  exit 3
fi

used_lg_file='error'
find_language_file "$1"
ex_status=0
while [[ $# -gt 1 ]]; do
  check_file $used_lg_file "$2"
  ex_status=$(($? || ex_status))
  shift
done

exit $ex_status
