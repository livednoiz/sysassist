# LVM Snapshot Automation

Dieses Skript automatisiert die Erstellung von Snapshots auf LVM-Volumes, um regelmäßige Backups des Systems und seiner Daten zu gewährleisten. Es bietet einfache Anpassungsoptionen und kann in regelmäßigen Abständen ausgeführt werden, um eine effiziente Verwaltung der Snapshots zu ermöglichen.

---

## 📂 Installation

1. **Voraussetzungen**:
   - Ein laufendes LVM-System
   - `lvm2` Paket (für LVM-Befehle)
   - Ein Cron-Job, um das Skript regelmäßig auszuführen (optional)

2. **Skript herunterladen**:
   - Klone das Repository oder lade das Skript manuell herunter.

3. **Berechtigungen**:
   - Stelle sicher, dass das Skript mit ausreichenden Berechtigungen ausgeführt wird, um LVM-Befehle auszuführen.

4. **Skript ausführen**:
   - Führe das Skript aus, um einen Snapshot zu erstellen:
     ```bash
     ./lvm_snapshot.sh
     ```
---

## ⚙️ Nutzung

- Das Skript erstellt Snapshots basierend auf den in der Konfigurationsdatei definierten Volumes.
- Standardmäßig wird der Snapshot auf das Präfix "snap-" gesetzt.
- Das Skript prüft auch, ob ausreichend Platz auf der Partition vorhanden ist, um Snapshots zu erstellen.

---

## 🛠️ Konfiguration

Die Konfigurationsdatei `config.sh` enthält alle wichtigen Einstellungen, die du nach Bedarf anpassen kannst:

```bash
# Konfiguration für LVM Snapshot Automation

# Volume Group und Logical Volumes
VG_NAME="your_volume_group"
LV_NAME="your_logical_volume"

# Verzeichnis für Backups
BACKUP_DIR="/mnt/backup"

# Snapshot Präfix
SNAPSHOT_PREFIX="snap-"

# Maximale Anzahl an Snapshots, die behalten werden sollen
MAX_SNAPSHOTS=5

```
---

## 📅 Automatisierung mit Cron

Um das Skript regelmäßig auszuführen, kannst du einen Cron-Job einrichten, der das Skript in regelmäßigen Abständen ausführt:

Öffne die Crontab-Konfiguration:

```bash
crontab -e
Füge eine Zeile hinzu, um das Skript täglich um 3 Uhr morgens auszuführen:
0 3 * * * /path/to/lvm_snapshot.sh

``` 

---

## 💬 Fehlersuche

Falls das Skript nicht wie erwartet funktioniert, überprüfe die folgenden Punkte:

LVM-Befehle: Stelle sicher, dass lvm2 korrekt installiert ist.

Berechtigungen: Überprüfe, ob du die notwendigen Rechte hast, um LVM-Befehle auszuführen und Snapshots zu erstellen.

Platz: Vergewissere dich, dass ausreichend freier Speicherplatz für Snapshots verfügbar ist.

---

## 🔐 Sicherheitshinweise

Passwortschutz: Stelle sicher, dass nur autorisierte Benutzer das Skript ausführen können, insbesondere auf Produktionssystemen.

Snapshoterstellung: Überprüfe regelmäßig, ob die Snapshots ordnungsgemäß erstellt werden, um die Integrität der Backups sicherzustellen.

---

## 🔗 Weitere Informationen

Weitere Informationen zu LVM und Snapshots findest du in der offiziellen LVM-Dokumentation:

* LVM Dokumentation