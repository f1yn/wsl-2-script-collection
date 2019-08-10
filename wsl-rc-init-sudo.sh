#!/bin/bash

# The elevated portion of wsl-rc-init.sh. This script is responsible
# For running simple commands on the first session ran within WSL.


echo "
Authentication details accepted. Starting core features and services...
";

# Load sysctl things (ideal for starting watchers)
sysctl -p > /dev/null

# Add any critical services here as array elements
declare -a AllServices=(
	"postgresql"
	"docker"
)

# Start each individual ser
for ServiceName in ${AllServices[@]}; do
	service $ServiceName start;
done
