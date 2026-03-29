#!/bin/bash
# Script 1: System Identity Report
# Displays system information as a welcome screen
# Author: [Your Name]
# Date: $(date +%Y-%m-%d)

echo "=========================================="
echo "         SYSTEM IDENTITY REPORT           "
echo "=========================================="
echo ""

# Get Linux distribution
if command -v lsb_release &>/dev/null; then
    DISTRO=$(lsb_release -d | cut -f2)
else
    DISTRO=$(cat /etc/os-release 2>/dev/null | grep "^PRETTY_NAME" | cut -d'"' -f2)
    if [ -z "$DISTRO" ]; then
        DISTRO="Unknown Distribution"
    fi
fi
echo "Linux Distribution: $DISTRO"

# Get kernel version
KERNEL=$(uname -r)
echo "Kernel Version:     $KERNEL"

echo ""

# Get current user
USER=$(vagesh sharma)
echo "Logged-in User:     $USER"

# Get home directory
HOME_DIR=$HOME
echo "Home Directory:     $HOME_DIR"

echo ""

# Get system uptime
UPTIME=$(uptime -p 2>/dev/null || uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}')
echo "System Uptime:      $UPTIME"

# Get current date and time
CURRENT_DATE=$(date "+%A, %B %d, %Y %H:%M:%S")
echo "Current Date/Time:  $CURRENT_DATE"

echo ""

# OS License information
echo "OS License:         GNU General Public License v2.0"
echo "=========================================="
