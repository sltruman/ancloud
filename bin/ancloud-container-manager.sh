#!/bin/bash
set -x

# We need to put the rootfs somewhere where we can modify some parts of the content on first boot (namely file permissions).
# Other than that nothing should ever modify the content of the rootfs.

DATA_PATH=/home/sl.truman/Desktop
ANDROID_IMG=$DATA_PATH/android.img

start() {
	# Make sure our setup path for the container rootfs is present as lxc is statically configured for this path.
	mkdir -p $DATA_PATH/lxc

	# We start the bridge here as long as a oneshot service unit is not possible. 
	# See snapcraft.yaml for further details.
	#$DATA_PATH/ancloud-bridge.sh start

	# Ensure FUSE support for user namespaces is enabled
	echo Y | tee /sys/module/fuse/parameters/userns_mounts || echo "WARNING: kernel doesn't support fuse in user namespaces"

	EXTRA_ARGS=
	EXTRA_ARGS="$EXTRA_ARGS --use-rootfs-overlay"
	EXTRA_ARGS="$EXTRA_ARGS --privileged"
	EXTRA_ARGS="$EXTRA_ARGS --container-network-address=192.168.240.2"
	EXTRA_ARGS="$EXTRA_ARGS --container-network-gateway=192.168.240.1"
	EXTRA_ARGS="$EXTRA_ARGS --container-network-dns-servers=192.168.240.1"
	
	# Ensure we have binderfs mounted when our kernel supports it
	if cat /proc/filesystems | grep -q binder ; then
		mkdir -p "$DATA_PATH"/binderfs
		# Remove old mounts so that we start fresh without any devices allocated
		if cat /proc/mounts | grep -q "binder $DATA_PATH/binderfs" ; then
			umount "$DATA_PATH"/binderfs
		fi
		mount -t binder none "$DATA_PATH"/binderfs
	fi

	exec $DATA_PATH/bin/anbox.sh container-manager \
		--data-path="$DATA_PATH" \
		--android-image="$ANDROID_IMG" \
		--daemon \
		$EXTRA_ARGS
}

stop() {
	$DATA_PATH/bin/anbox-bridge.sh stop
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	*)
		echo "ERROR: Unknown command '$1'"
		exit 1
		;;
esac
