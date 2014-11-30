zfs-utils
=========
A collection of scripts I created for my own use to ease working with zfs.

## Utilities available:

### unmount_zfs.sh

A systemd hook which automatically exports the specified zfs pool. Any process accessing this pool is killed with SIGKILL. Install this script by copying the `usr` folder to your root directory and replacing the pool name `tank` with the name of your pool.


### zfs_keep_awake.sh

Imports the specified pool and touches the file ".keep_awake" every 20 seconds to avoid external USB racks (eg. ICY BOX) to shutdown while the zfs pool is still imported. On exit (eg. with ctrl-c) this script automatically exports the pool.
