#!/bin/bash

ALERT_MAIL="deine@email.de"
MEGACLI="/usr/sbin/MegaCli"

# RAID-Zustand abfragen
OUTPUT=$($MEGACLI -PDList -aALL)

# Problematische Geräte finden
ISSUE=$(echo "$OUTPUT" | egrep "Firmware state: (Failed|Unconfigured)|Media Error Count: [1-9]|Predictive Failure Count: [1-9]")

if [ -n "$ISSUE" ]; then
    echo -e "RAID-Fehler erkannt:\n\n$ISSUE" | mail -s "[RAID-WARNUNG] Möglicher Festplattendefekt erkannt!" "$ALERT_MAIL"
fi
# RAID-Zustand abfragen
OUTPUT=$($MEGACLI -LDInfo -Lall -aALL)