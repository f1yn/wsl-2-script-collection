#!/bin/bash

# Minimal helper for ensuring that essential services are started before
# the first session opens. Because WSL uses init, there's an inherit lack
# of auto startable services during init.

# This script will use a filesystem-based workaround to determine if the
# WSL instance is fresh (mmm), and if so it will attempt to commit core 
# commands. NOTE THAT THIS WILL REQUEST YOUR SUDO auth

CUSTOM_WSL_BOOT_FLAG="/tmp/wsl-boot-time"

# Get the reported WSL init time
system_started_at="$(uptime -s)"

# Flag to determine if we should commit the init process
should_commit_init=false

if [ -f "$CUSTOM_WSL_BOOT_FLAG" ]; then
	# Verify that the expected start time matches the cached one
	if [ "$system_started_at" != "$(cat $CUSTOM_WSL_BOOT_FLAG)" ]; then
		# The system needs to init
		should_commit_init=true
	fi
else
	# otherwise set the value of the tmp file
	should_commit_init=true
fi

if [ $should_commit_init = false ]; then
	# No need to commit so start
	# echo "Already started"
	exit
fi

echo "Booting essential startup commands:"
sudo bash ./wsl-rc-init-sudo.sh

# Ensure that we commit the uptime to the temporary flag file
echo $system_started_at > $CUSTOM_WSL_BOOT_FLAG