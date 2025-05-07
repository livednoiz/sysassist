#!/bin/bash
# rsync_backup.sh
# Sicheres rsync-Backup mit Logging

set -euo pipefail

# === Konfiguration ===
SOURCE="/home"                                # Quellverzeichnis
TARGET="/mnt/backup/$(hostname)-$(date +%F)"  # Zielverzeichnis mit Datumsstempel
LOGFILE="/var/log/rsync_backup.log"           # Log-Datei
EXCLUDES=("--exclude=.cache" "--exclude=node_modules")

# === Backup starten ===
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Starte Backup von $SOURCE nach $TARGET" | tee -a "$LOGFILE"

mkdir -p "$TARGET"

rsync -avh --delete "${EXCLUDES[@]}" "$SOURCE/" "$TARGET/" 2>&1 | tee -a "$LOGFILE"

# === Abschluss ===
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Backup abgeschlossen." | tee -a "$LOGFILE"
exit 0
# === Ende des Skripts ===
# Dieses Skript führt ein sicheres rsync-Backup des Quellverzeichnisses durch und speichert es im Zielverzeichnis.
# Es werden nur die neuesten Dateien gesichert, und alte Dateien werden gelöscht.
# Die Log-Datei wird aktualisiert, um den Fortschritt und mögliche Fehler zu protokollieren.
# Stellen Sie sicher, dass das Skript ausführbar ist:
# chmod +x rsync_backup.sh
# Fügen Sie das Skript zu cron hinzu, um regelmäßige Backups zu planen:
# crontab -e
# 0 2 * * * /path/to/rsync_backup.sh
# Dies führt das Skript täglich um 2 Uhr morgens aus.
# Stellen Sie sicher, dass das Zielverzeichnis existiert und die richtigen Berechtigungen hat.
# Überprüfen Sie die Log-Datei regelmäßig, um sicherzustellen, dass das Backup erfolgreich war.
# Bei Problemen überprüfen Sie die rsync-Dokumentation oder die Log-Datei auf Fehler.
# Hinweis: Dieses Skript ist ein einfaches Beispiel und sollte an Ihre spezifischen Anforderungen angepasst werden.
# Sie können zusätzliche Optionen zu rsync hinzufügen, um die Leistung oder Sicherheit zu verbessern.
# Weitere Optionen finden Sie in der rsync-Dokumentation: https://download.samba.org/pub/rsync/rsync.html
# Beachten Sie, dass rsync über SSH eine sichere Übertragung ermöglicht.
# Beispiel für die Verwendung von rsync über SSH:
# rsync -avz -e "ssh -p 22" --delete "${EXCLUDES[@]}" "$SOURCE/" user@remote_host:"$TARGET/" 2>&1 | tee -a "$LOGFILE"
# Stellen Sie sicher, dass SSH-Schlüssel eingerichtet sind, um die Authentifizierung zu erleichtern.
# Dies ist ein einfaches Skript und sollte nicht in Produktionsumgebungen ohne gründliche Tests verwendet werden.
# Überprüfen Sie die Berechtigungen des Skripts und der Log-Datei, um sicherzustellen, dass sie sicher sind.
# Achten Sie darauf, sensible Daten zu schützen und sicherzustellen, dass das Backup regelmäßig getestet wird.
# Testen Sie das Skript in einer sicheren Umgebung, bevor Sie es in einer Produktionsumgebung verwenden.
# Überprüfen Sie die Integrität des Backups regelmäßig, um sicherzustellen, dass es korrekt funktioniert.
# Fügen Sie zusätzliche Sicherheitsmaßnahmen hinzu, wie z.B. Verschlüsselung der Backup-Daten.