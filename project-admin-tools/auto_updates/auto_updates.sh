#!/bin/bash

# Auto-Sicherheitsupdates mit Reboot-Check
# Unterstützt: Debian/Ubuntu + RHEL/CentOS/Alma

LOG_DIR="$(dirname "$0")/log"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/update.log"
DATE=$(date '+%F %T')

echo "[$DATE] --- System Update gestartet ---" >> "$LOG_FILE"

# Erkennung der Distribution
if [ -f /etc/debian_version ]; then
    DISTRO="Debian"
    echo "[$DATE] Debian-basiertes System erkannt." >> "$LOG_FILE"
    apt update >> "$LOG_FILE" 2>&1
    apt upgrade -y >> "$LOG_FILE" 2>&1
    NEEDS_REBOOT_FILE="/var/run/reboot-required"
elif [ -f /etc/redhat-release ]; then
    DISTRO="RHEL"
    echo "[$DATE] RHEL-basiertes System erkannt." >> "$LOG_FILE"
    yum update -y >> "$LOG_FILE" 2>&1 || dnf upgrade -y >> "$LOG_FILE" 2>&1
    NEEDS_REBOOT_FILE="/var/run/reboot-required"
else
    echo "[$DATE] Distribution nicht unterstützt." >> "$LOG_FILE"
    exit 1
fi

# Reboot nötig?
if [ -f "$NEEDS_REBOOT_FILE" ]; then
    echo "[$DATE] ⚠️  Reboot erforderlich nach Updates." >> "$LOG_FILE"
    REBOOT_NEEDED=true
else
    echo "[$DATE] Kein Reboot notwendig." >> "$LOG_FILE"
    REBOOT_NEEDED=false
fi

echo "[$DATE] --- Update abgeschlossen ---" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Optionale Benachrichtigung
NOTIFY_SCRIPT="$(dirname "$0")/config/notify.sh"
if [ -x "$NOTIFY_SCRIPT" ]; then
    "$NOTIFY_SCRIPT" "$REBOOT_NEEDED"
fi
# Optionaler Reboot
if [ "$REBOOT_NEEDED" = true ]; then
    echo "[$DATE] System wird neu gestartet..." >> "$LOG_FILE"
    # Hier den Reboot-Befehl einfügen, z.B.:
    # reboot
else
    echo "[$DATE] Kein Reboot erforderlich." >> "$LOG_FILE"
fi
echo "[$DATE] --- Update-Skript beendet ---" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
# Ende des Skripts
# Hinweis: Der Reboot-Befehl ist auskommentiert, um unbeabsichtigte Neustarts zu vermeiden.
# Bitte den Befehl aktivieren, wenn ein Neustart gewünscht ist.
# Das Skript kann mit Cronjobs oder Systemd-Services geplant werden.
# Beispiel für einen Cronjob (täglich um 2 Uhr):
# 0 2 * * * /path/to/auto_updates.sh
# Beispiel für einen Systemd-Service:
# [Unit]
# Description=Automatisierte Updates
# After=network.target
# [Service]
# Type=oneshot
# ExecStart=/path/to/auto_updates.sh    