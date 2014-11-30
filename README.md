zfs-utils
=========
A collection of scripts I created for my own use to ease working with zfs.

## Utilities available:

### unmount_zfs.sh

A systemd hook which automatically exports the specified zfs pool. Any process accessing this pool is killed with SIGKILL. Install this script in the by copying the etc folder to your root directory.


### zfs_keep_awake.sh

Imports the specified pool and touches the file "keep_awake" every 20 seconds to avoid external USB racks (eg. ICY BOX) to shutdown while the zfs is still mounted. On exit (eg. with ctrl-c) this script automatically exports the pool.
