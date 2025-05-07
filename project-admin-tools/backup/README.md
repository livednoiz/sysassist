# 📦 Rsync Backup Skript – README

Willkommen zum Backup-Modul mit `rsync`! Dieses Skript wurde entwickelt, um einfach, sicher und automatisiert Daten von einer Quelle zu einem Backup-Ziel zu übertragen.

## 🔧 Funktionen

* 🔁 **Inkrementelle Sicherung** mit `rsync`
* ⏰ **Zeitgestempelte Verzeichnisse** für versionierte Backups
* 📜 **Protokollierung** aller Aktionen in eine Logdatei
* 🚫 **Ausschlusslisten** für unerwünschte Dateien/Ordner
* 💬 **Optionale Benachrichtigung** über Matrix, E-Mail oder Telegram (später integrierbar)

## 🧪 Voraussetzungen

* `rsync`
* `cron` (für automatische Ausführung)
* Schreibrechte am Zielpfad

## 📁 Verzeichnisstruktur

```
project-admin-tools/
├── backups/
│   └── backup_rsync.sh
└── logs/
    └── backup_rsync-YYYYMMDD.log
```

## 🛠️ Konfiguration

Bearbeite im Skript folgende Variablen:

```bash
SRC="/pfad/zur/quelle"
DEST="/pfad/zum/ziel"
LOGDIR="/pfad/zu/logs"
EXCLUDE_FILE="/pfad/zu/exclude.txt"
```

## ▶️ Ausführung

Manuell:

```bash
bash backup_rsync.sh
```

Automatisch per `cron` (z. B. täglich um 2:00 Uhr):

```cron
0 2 * * * /pfad/zu/backup_rsync.sh >> /pfad/zu/logs/cron.log 2>&1
```

## ❌ Ausschlussliste

Dateien/Verzeichnisse, die nicht gesichert werden sollen, kommen in die Datei `exclude.txt`, z. B.:

```
*.tmp
/dev/*
/proc/*
/sys/*
```

## 🧠 Weiterentwicklungsideen

* 📬 Integration von **Benachrichtigungen** (z. B. Matrix, Mail)
* 🧹 Alte Backups automatisch löschen (Rotation)
* 🧪 Healthcheck-Ping an externen Dienst

## 👨‍🔧 Autor & Wartung

Ein Modul aus der Reihe `project-admin-tools` 🧰 – für eine saubere, nachvollziehbare und wartbare Admin-Infrastruktur.

---

> 🛡️ Backup ist keine Option – es ist Pflicht! Plane regelmäßige Tests zur Wiederherstellung ein.
