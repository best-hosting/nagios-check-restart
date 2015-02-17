#!/bin/sh

readonly save_stdout=7
exec $save_stdout>&1

exec /usr/local/sbin/write-plugin-cache.sh \
  /usr/local/lib/nagios/plugins/checkrestart \
    --stdout-to-fd $save_stdout \
    "$@"

