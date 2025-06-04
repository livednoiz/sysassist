#!/bin/bash

MEGACLI="/usr/sbin/MegaCli"
if [ ! -x "$MEGACLI" ]; then
    echo "UNKNOWN: MegaCli not found at $MEGACLI"
    exit 3
fi

OUTPUT=$($MEGACLI -LDInfo -Lall -aALL 2>/dev/null)
VDSTATE=$(echo "$OUTPUT" | grep -i "State" | awk '{print $3}')

# Check for Physical Drive status
PD_OUTPUT=$($MEGACLI -PDList -aALL 2>/dev/null)

# Count offline, failed, and predictive failure disks
OFFLINE_COUNT=$(echo "$PD_OUTPUT" | grep -c "Firmware state: Offline")
FAILED_COUNT=$(echo "$PD_OUTPUT" | grep -c "Firmware state: Failed")
PREDFAIL_COUNT=$(echo "$PD_OUTPUT" | grep -c "Predictive Failure")

TOTAL_ISSUES=$((OFFLINE_COUNT + FAILED_COUNT + PREDFAIL_COUNT))

# Generate Output
if [[ "$VDSTATE" != "Optimal" ]] || [[ "$TOTAL_ISSUES" -gt 0 ]]; then
    echo "CRITICAL: RAID status is $VDSTATE | Offline: $OFFLINE_COUNT, Failed: $FAILED_COUNT, Predictive Failures: $PREDFAIL_COUNT"
    exit 2
else
    echo "OK: RAID status is $VDSTATE | No issues detected"
    exit 0
fi
# End of script