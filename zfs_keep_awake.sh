#!/bin/bash -eu

POOL=$1

if [[ -z $POOL ]]
then
	echo Error: No pool specified
	POOL='-h'
fi

if [[ $POOL == --help || $POOL == -h ]]
then
	echo \
'Usage (as root):' $0 '<pool>
Imports the specified pool and touches the file "keep_awake" every 20 seconds
to avoid external USB racks (eg. ICY BOX) to shutdown while the zfs is still
mounted. On exit (eg. with ctrl-c) this script automatically exports the pool.
	-h, --help	Display this help
'
	exit 1
fi

if [[ $(id -u) != 0 ]]
then
	echo You must be root! Bye bye... 1>&2
	exit 2
fi

zpool import $POOL
echo Import of $POOL successful

graceful_unmount() {
	while ! zpool export $POOL
	do
		echo Failed to unmount $POOL, potential problems:
		lsof | grep $POOL
		sleep 1
	done
	echo Export of $POOL successful
}

keep_awake() {
	touch /$POOL/keep_awake
}

trap 'keep_awake && graceful_unmount' EXIT

while keep_awake
do
	sleep 20
done

