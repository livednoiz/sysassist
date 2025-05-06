#!/bin/bash

# System Upgrade Script for RPM-based Distros (CentOS, AlmaLinux, Rocky)
# Version: 0.1.0

LOGFILE="/var/log/rpm-upgrade.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$DATE] === Starting RPM-based system upgrade ===" | tee -a "$LOGFILE"

# Check if user is root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root." | tee -a "$LOGFILE"
    exit 1
fi

# Update the package list
echo "[$DATE] Updating package cache..." | tee -a "$LOGFILE"
dnf makecache fast >> "$LOGFILE" 2>&1

# Perform full upgrade
echo "[$DATE] Running full system upgrade..." | tee -a "$LOGFILE"
dnf upgrade -y >> "$LOGFILE" 2>&1

# Optional: clean old cached packages
echo "[$DATE] Cleaning up old cache..." | tee -a "$LOGFILE"
dnf clean all >> "$LOGFILE" 2>&1

echo "[$DATE] === System upgrade completed ===" | tee -a "$LOGFILE"
echo "[$DATE] Please reboot the system if required." | tee -a "$LOGFILE"
echo "[$DATE] === End of RPM-based system upgrade ===" | tee -a "$LOGFILE"
# Reboot the system if required
if [ -f /var/run/reboot-required ]; then
    echo "[$DATE] Rebooting the system..." | tee -a "$LOGFILE"
    reboot
else
    echo "[$DATE] No reboot required." | tee -a "$LOGFILE"
fi
# End of script
# Note: This script is designed for RPM-based distributions like CentOS, AlmaLinux, and Rocky Linux.
# It is recommended to test this script in a safe environment before deploying it in production.
# Make sure to have a backup of important data before running the upgrade.
# This script is provided as-is without any warranty. Use at your own risk.
# For more information on dnf and its options, refer to the official documentation:
# https://dnf.readthedocs.io/en/latest/
# For more information on system upgrades and best practices, refer to the official documentation:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/upgrading_and_managing_your_system/index
# For more information on AlmaLinux and Rocky Linux, refer to their official documentation:
# https://almalinux.org/docs/
# https://rockylinux.org/docs/
# For more information on system administration and best practices, refer to the official documentation:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/system_administrators_guide/index
# For more information on system security and best practices, refer to the official documentation:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/security_guide/index
# For more information on system performance tuning and best practices, refer to the official documentation:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/performance_tuning_guide/index
# For more information on system monitoring and best practices, refer to the official documentation:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/monitoring_and_tuning_your_system/index
# For more information on system troubleshooting and best practices, refer to the official documentation:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/troubleshooting_guide/index
# For more information on system backup and recovery and best practices, refer to the official documentation:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/backup_and_recovery_guide/index