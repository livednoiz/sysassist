# 🔄 Auto-Updates für Debian/RedHat-basierte Systeme

Dieses Tool automatisiert Sicherheits- und Systemupdates für Debian/Ubuntu- sowie RHEL-basierte Distributionen (z. B. CentOS, AlmaLinux, Rocky Linux). Es erkennt automatisch die zugrunde liegende Distribution, spielt Updates ein und protokolliert den gesamten Ablauf. Optional erkennt es, ob ein Neustart notwendig ist und kann Benachrichtigungen versenden.

## 📁 Verzeichnisstruktur

```
project-admin-tools/
└── auto-updates/
    ├── auto_update.sh         # Hauptskript
    ├── config/
    │   └── notify.sh         # Optionales Benachrichtigungsskript (E-Mail, Matrix etc.)
    └── log/
        └── update.log       # Automatisch gefülltes Logfile
```

---

Beide Skripte beinhalten:

* ✅ **Systemaktualisierung** (Paketquellen + installierte Pakete)
* 🧹 **automatische Bereinigung** nicht mehr benötigter Pakete
* 📝 **Logging-Funktion**: Alle Ausgaben landen in `/var/log/sys_updates.log`

---

## 🛠️ Verwendung

```bash
sudo bash auto  _update.sh     # für Debian-basierte Systeme
```

> **Hinweis**: Die Skripte sollten regelmäßig per `cron` oder `systemd`-Timer ausgeführt werden.

---

## ⏱️ Automatisierungsidee

```cron
0 4 * * * root /pfad/zum/auto_update_deb.sh > /dev/null 2>&1
```

Oder unter `systemd` einen Timer-Service erstellen, um regelmäßige Updates sicherzustellen.

---

## 🔒 Sicherheitshinweis

Diese Skripte führen System-Updates automatisch durch – stelle sicher, dass sie in produktiven Umgebungen zunächst getestet werden!

---

📎 Lizenz

Dieses Projekt steht unter der MIT-Lizenz. Nutzung auf eigene Verantwortung.

---

## Weiterentwicklungsideen

* Neustart automatisch planen (z. B. via `at` oder `systemd-reboot`)
* Support für Arch-/Alpine-Systeme
* Logging per `logger` ins Syslog
* Webhook-basierte Benachrichtigung (z. B. Discord, Slack)
