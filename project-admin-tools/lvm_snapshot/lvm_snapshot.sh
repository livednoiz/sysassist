#!/bin/bash

# Konfiguration
VG_NAME="vg0"               # Volume Group Name
LV_NAME="root"              # Logical Volume Name
SNAP_PREFIX="snap"          # Snapshot Namenspräfix
SNAP_SIZE="1G"              # Snapshot-Größe
MAX_SNAPS=5                 # Maximale Anzahl Snapshots

TIMESTAMP=$(date +%Y%m%d-%H%M)
SNAP_NAME="${SNAP_PREFIX}-${LV_NAME}-${TIMESTAMP}"

log_file="/var/log/lvm_snapshots.log"

log() {
    echo "[$(date)] $1" | tee -a "$log_file"
}

log "Erstelle Snapshot: $SNAP_NAME"
lvcreate -L "$SNAP_SIZE" -s -n "$SNAP_NAME" "/dev/$VG_NAME/$LV_NAME"

if [ $? -eq 0 ]; then
    log "Snapshot erfolgreich erstellt."
else
    log "Fehler beim Erstellen des Snapshots."
    exit 1
fi

# Alte Snapshots bereinigen
SNAPSHOTS=$(lvs --noheadings -o lv_name "$VG_NAME" | grep "${SNAP_PREFIX}-${LV_NAME}" | sort)

COUNT=$(echo "$SNAPSHOTS" | wc -l)

if [ "$COUNT" -gt "$MAX_SNAPS" ]; then
    TO_DELETE=$(echo "$SNAPSHOTS" | head -n $(($COUNT - $MAX_SNAPS)))
    for snap in $TO_DELETE; do
        log "Entferne alten Snapshot: $snap"
        lvremove -f "/dev/$VG_NAME/$snap"
    done
fi
log "Bereinigung der Snapshots abgeschlossen."
log "Snapshot-Prozess abgeschlossen."
exit 0
# === Ende des Skripts ===
# Dieses Skript erstellt einen LVM-Snapshot eines logischen Volumes und bereinigt alte Snapshots.
# Es wird ein Zeitstempel für den Snapshot-Namen verwendet, um ihn eindeutig zu machen.
# Stellen Sie sicher, dass das Skript mit den richtigen Berechtigungen ausgeführt wird.
# Überprüfen Sie die LVM-Dokumentation für weitere Informationen zu den verwendeten Befehlen.
# Beispiel für die Verwendung des Skripts:
# chmod +x lvm_snapshot.sh
# ./lvm_snapshot.sh
# Fügen Sie das Skript zu cron hinzu, um regelmäßige Snapshots zu erstellen:
# crontab -e
# 0 * * * * /path/to/lvm_snapshot.sh
# Dies führt das Skript stündlich aus.
# Stellen Sie sicher, dass das Skript ausführbar ist und die richtigen Berechtigungen hat.
# Überprüfen Sie die Log-Datei regelmäßig, um sicherzustellen, dass die Snapshots erfolgreich erstellt wurden.
# Bei Problemen überprüfen Sie die LVM-Dokumentation oder die Log-Datei auf Fehler.
# Hinweis: Dieses Skript ist ein einfaches Beispiel und sollte an Ihre spezifischen Anforderungen angepasst werden.
# Sie können zusätzliche Optionen zu lvcreate hinzufügen, um die Leistung oder Sicherheit zu verbessern.
# Weitere Optionen finden Sie in der LVM-Dokumentation: https://www.tldp.org/HOWTO/LVM-HOWTO/
# Beachten Sie, dass LVM eine flexible Verwaltung von logischen Volumes ermöglicht.
# Beispiel für die Verwendung von LVM über SSH:
# ssh user@remote_host "lvcreate -L $SNAP_SIZE -s -n $SNAP_NAME /dev/$VG_NAME/$LV_NAME"
# Stellen Sie sicher, dass SSH-Schlüssel eingerichtet sind, um die Authentifizierung zu erleichtern.
# Dies ist ein einfaches Skript und sollte nicht in Produktionsumgebungen ohne gründliche Tests verwendet werden.
# Überprüfen Sie die Berechtigungen des Skripts und der Log-Datei, um sicherzustellen, dass sie sicher sind.
# Achten Sie darauf, sensible Daten zu schützen und sicherzustellen, dass die Snapshots regelmäßig getestet werden.
# Testen Sie das Skript in einer sicheren Umgebung, bevor Sie es in einer Produktionsumgebung verwenden.
# Überprüfen Sie die Integrität der Snapshots regelmäßig, um sicherzustellen, dass sie korrekt funktionieren.
# Fügen Sie zusätzliche Sicherheitsmaßnahmen hinzu, wie z.B. Verschlüsselung der Snapshot-Daten.
# Überprüfen Sie die LVM-Dokumentation für weitere Informationen zu den verwendeten Befehlen.