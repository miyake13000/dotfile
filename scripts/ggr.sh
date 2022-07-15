#!/bin/bash
# @(#) google to change argument of w3m command from URL to search word.
#
ARGS=""
ARG=""

function showUsage() {
    cat <<_EOT_
  Usage:
    ./google
  Description:
    Read this script
  Options:
    -h|--help : show usage.
_EOT_
exit 1
}

# Check args
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    showUsage
fi

# Connect arguments as character string
for ARG in "$@"
do
    ARGS="${ARGS}+${ARG}"
done
ARGS=$(echo ${ARGS} | sed 's/^\+//')

# Start web searching
w3m http://www.google.co.jp/search?q="${ARGS}"
