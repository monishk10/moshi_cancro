#!/system/bin/sh
# Tweak script for Xceed/Xcelerate kernels

busybox mount -o remount,rw /system
busybox mount -t rootfs -o remount,rw rootfs

# Defining constants
MTD=`ls -d /sys/block/mtd*`;
LOOP=`ls -d /sys/block/loop*`;
RAM=`ls -d /sys/block/ram*`;
MMC=`ls -d /sys/block/mmc*`;

# Synapse initialization
busybox chmod -R 755 /res/synapse
busybox ln -fs /res/synapse/uci /sbin/uci
/sbin/uci

# Tweaks
echo 0 > /proc/sys/kernel/randomize_va_space;
echo "70" > /proc/sys/vm/vfs_cache_pressure;
echo "5" > /proc/sys/vm/dirty_background_ratio;
echo "3000" > /proc/sys/vm/dirty_writeback_centisecs;
echo "500" > /proc/sys/vm/dirty_expire_centisecs;
echo "5120000" > /proc/sys/vm/dirty_background_bytes;

# Rotational tweaks
for j in $MTD $LOOP $RAM $MMC;
do
	echo "0" > $j/queue/rotational;
done;

busybox mount -t rootfs -o remount,ro rootfs
busybox mount -o remount,ro /system

