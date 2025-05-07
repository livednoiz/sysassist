# 🧰 project-admin-tools

> Hilfsskripte für Administratoren, die im Kontext von **SysAssist** wiederkehrende Aufgaben auf Linux-Systemen (v. a. Plesk) effizient automatisieren wollen.

Diese Sammlung enthält kleine, aber praktische Bash-Tools zur Systemprüfung, Benutzerverwaltung und vorbereitenden Aufgaben für Migration, Debugging oder Administration.

---

## 📂 Inhalt

### 📁 `adduser/`

Hilfsskripte zur schnellen Benutzeranlage – z. a. für Domains oder Projekte.

* **`hlp_dmn.sh`**
  Automatisiert die Einrichtung eines Benutzers inklusive Basisverzeichnissen.

---

### ⚖️ Hauptskripte

| Skript                        | Beschreibung                                                                                                                                                                                          |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `info.sh`                     | Interaktives Terminal-Menü zur Anzeige wichtiger Systeminfos wie Netzwerk, CPU, RAM, Prozesse, Kernel usw. Perfekt für einen schnellen Überblick bei Remotezugriff oder Erstkontakt mit einem System. |
| `deb-upgrade.sh`              | Helfer zur Paketquellen-Aktualisierung oder Release-Vorbereitung unter Debian-basierten Systemen. Wird ggf. für `apt`-basierte Server in der Migrationsphase eingesetzt.                              |
| `scripter.bash`               | Minimalistisches Tool zur schnellen Bearbeitung und ausführbaren Einrichtung eines neuen Shellscripts im Home-Verzeichnis. Ideal für spontane Skriptideen.                                            |
| `plesk_backup/`               | Enthält: **plesk_backup.sh** Führt ein strukturiertes Plesk-Backup (inkl. Datenbanken & Einstellungen) durch – verwendbar vor Migrationen oder als manuelles On-Demand-Backup.                       |
| `rhel_upgrade.sh` | Helfer zur Paketquellen-Aktualisierung  unter Red-Hat-basierten Systemen (ab Version 8)                                                                                                               |

---

## 💡 Einsatzszenarien

* 🔄 **Plesk-Migrationen vorbereiten** (Systeminfos auslesen, Nutzer vorbereiten, Pakete prüfen)
* 🧪 **Audits vereinfachen** (Mit `info.sh` den Zustand eines Systems erfassen)
* 💠 **Schnelles Admin-Onboarding** (Benutzer & Tools in Minutenschnelle bereitstellen)
* 💻 **Terminal-native Nutzung** (keine GUI-Abhängigkeiten, keine komplexen Setups)

---

## 🧪 Beispiel: `info.sh` in Aktion

```bash
cd project-admin-tools/
./info.sh
```

Navigiere mit **Pfeiltasten**, bestätige mit **Enter**, beende mit **Exit-Menüpunkt**.

---

## 🚀 Quickstart

```bash
git clone https://github.com/livednoiz/sysassist.git
cd sysassist/project-admin-tools/
chmod +x *.sh
./info.sh
```

---

## 🧑‍💻 Hinweis für Entwickler

Alle Skripte sind modular und transparent aufgebaut. Du kannst sie einzeln anpassen oder kombinieren. Neue Tools können leicht integriert werden – beachte dafür einfach die bestehende Struktur.

---

## 📝 Lizenz

MIT – Offen für jegliche Nutzung. Änderungen, Verbesserungen oder Ergänzungen willkommen!

---

> ✨ *Pragmatische Tools für pragmatische Admins – genau da, wo andere Lösungen zu groß oder zu schwerfällig wären.*

# ✅ Admin-Automation-Checklist

🔁 **Priorisierte Reihenfolge nach Wirkung & Einfachheit**

## ✅ 1. Systempflege & Updates
- [x] Sicherheitsupdates automatisieren
- [x] Upgrade-Skripte mit Logging (Debian/Red Hat)
- [x] Reboot-Benachrichtigung bei Kernel-Updates

## 💾 2. Backups & Snapshots
- [x] Automatische rsync- oder borg-Backups
- [x] Snapshot-Automation (LVM / ZFS / Btrfs)

## 🔐 3. Sicherheit
- [ ] Fail2Ban & IP-Whitelist/-Blacklist
- [ ] Rootkit-Scan (Chkrootkit / RKHunter)
- [ ] Integritätscheck mit AIDE oder OSSEC

## 📈 4. Monitoring & Status
- [ ] Ressourcennutzung loggen (RAM, CPU, Disk)
- [ ] Watchdog-Skripte für wichtige Dienste
- [ ] Alert-System bei Schwellenwertüberschreitung

## 🧰 5. Admin-Komfort
- [ ] Automatisiertes Anlegen von Benutzern inkl. SSH-Key-Setup
- [ ] Skript für Log-Analyse (z. B. /var/log/auth.log)
- [ ] Templates für neue Systemdienste (systemd)

## 📤 6. Benachrichtigungssystem
- [ ] Anbindung von E-Mail-Benachrichtigungen
- [ ] Matrix- oder Telegram-Bot für Status-Updates
- [ ] Wöchentlicher Report-Versand
