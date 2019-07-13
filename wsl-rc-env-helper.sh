#!/bin/bash

# Minimal helper script for easily displaying relevant environment
# information for local web development in a WSL 2.

# Intended to be included within the your ~/.bashrc or ~/.zshrc

# Get the primary IP address of WSL 2 distro (guest IP)
wsl_address="$(hostname -I | xargs)";

# Get the address of the Windows 10 host IP
host_address="$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')";

# Ensure the values are additionally exported for reuse in the env script
export WSL_IP=$wsl_address;
export WSL_HOST=$host_address;

# Ensure that git GPG (protected by a password) can be signed within a
# Microsoft-based TTY (such as conhost, Microsoft Terminal, or Fluent)
export GPG_TTY=$(tty);

echo "
$(uname -a)

This instance has been assigned $wsl_address (\$WSL_IP)
The Windows Host machine $(hostname) can be accessed from $host_address (\$WSL_HOST)
";