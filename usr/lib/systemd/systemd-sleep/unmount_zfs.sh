#!/bin/bash -e

POOL=tank

case $1/$2 in
  pre/*)
    if zfs list | grep -q "^${POOL} "
    then
	kill -9 $(lsof | grep /$POOL | sed -r "s/^[^ ]+ *([0-9]+).*/\1/" | tr '\n' ' ')
        zpool export -f $POOL
    fi
    ;;
  post/*)
    ;;
esac
