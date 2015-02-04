#!/bin/sh

# Args:
# 1 - cache file path.
# 2 - plugin command.
# 3.. - plugin args.

set -euf

readonly True=1
readonly False=0
readonly nl='
'

# Nagios return codes.
readonly ret_unkn=3
readonly ret_crit=2
readonly ret_warn=1
readonly ret_ok=0

plugin=''
ret="$ret_ok"
res=''

cache_file="$1"
shift


### Check args.
# Default cache directory, if path is relative.
if [ "${cache_file#.}" != "$cache_file" ]; then
    cache_file="$(pwd)/$cache_file"
elif [ "${cache_file#/}" = "$cache_file" ]; then
    cache_file="/var/cache/nagios3/$cache_file"
fi
readonly cache_file

if [ ! -d "$(dirname "$cache_file")" ]; then
    echo "$0: Error: cache directory $(dirname "$cache_file") does not exist." 1>&2
    exit 1
fi


### Main.
ret="$ret_ok"
res=''

plugin="${1:-}"
# `type` can't handle only relative path without leading dot. But i don't want
# to handle it at all.
if type "$plugin" >/dev/null 2>&1; then
    shift
    res="$("$plugin" "$@")" || ret="$?"
else
    ret="$ret_unkn"
    res="Can't execute plugin '$plugin'"
fi

{
    if [ "$ret" = "$ret_ok" ]; then
	res="${res:-OK}"
    elif [ "$ret" = "$ret_warn" ]; then
	res="${res:-Some warning..}"
    elif [ "$ret" = "$ret_crit" ]; then
	res="${res:-Some critical..}"
    elif [ "$ret" = "$ret_unkn" ]; then
	res="${res:-Some unknown..}"
    else
	res="${res:+Unexpected plugin exit code '$ret'$nl$res}"
	res="${res:-Unexpected plugin exit code '$ret'}"
	ret="$ret_unkn"
    fi
    echo "$ret"
    echo "$res" | paste -d, -s
} > "$cache_file"

