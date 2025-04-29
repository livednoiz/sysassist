# 🔐 Plesk Backup & Migration Tutorial

Dieses Tutorial beschreibt Schritt für Schritt, wie man eine vollständige Sicherung einer Plesk-Installation auf einem CentOS 7-Server durchführt. Ziel ist es, die Daten auf einem neuen System (z. B. AlmaLinux 8) wiederherstellen zu können.

---

## 📦 Ziel dieses Backups

✔️ Vollständige Sicherung von:

- Websites & Dateien  
- Datenbanken (MariaDB)  
- Kunden & Abonnements  
- E-Mail-Daten  
- Systemkonfiguration & Lizenzen

---

## ⚙️ Voraussetzungen

- Root-Zugriff auf das CentOS-7-Plesk-System
- Genügend Speicherplatz für Backupdaten
- Optional: Externer Server für Backup-Offload

---

## 📁 Verzeichnisstruktur für das Backup

```bash
mkdir -p /root/plesk-backup/{configs,databases,mail,web,plesk-dump}
cd /root/plesk-backup
```

---

## 🗂️ Schritt 1 – Vollständiges Plesk-Backup (empfohlen)

Erzeugt ein internes Plesk-Backup, welches später via CLI oder GUI wiederhergestellt werden kann:

```bash
plesk bin pleskbackup server --output-file=plesk-dump/full-server-backup.tar
```

Optional inkrementell:
```bash
plesk bin pleskbackup server --incremental --output-file=plesk-dump/inc-backup.tar
```

---

## 🟢 Schritt 2 – Datenbankdump (MariaDB)

Redundante Sicherung aller Datenbanken:

```bash
mysqldump -A -uadmin -p$(cat /etc/psa/.psa.shadow) > databases/all-databases.sql
```

---

## 📩 Schritt 3 – Mails sichern

```bash
cp -a /var/qmail /root/plesk-backup/mail/
cp -a /var/mailnames /root/plesk-backup/mail/
```

---

## 🌐 Schritt 4 – Web-Inhalte sichern

```bash
cp -a /var/www/vhosts /root/plesk-backup/web/
```

---

## ⚙️ Schritt 5 – Konfigurationen sichern

```bash
cp -a /etc/httpd /root/plesk-backup/configs/httpd
cp -a /etc/nginx /root/plesk-backup/configs/nginx
cp -a /etc/php* /root/plesk-backup/configs/php
cp -a /etc/named.conf /root/plesk-backup/configs/
cp -a /etc/fail2ban /root/plesk-backup/configs/fail2ban
```

---

## 🦾 Schritt 6 – Plesk Konfiguration + Lizenz sichern

```bash
cp -a /etc/psa /root/plesk-backup/configs/psa
cp -a /etc/sw-cp-server /root/plesk-backup/configs/
plesk bin license --show > configs/license.txt
```

---

## 📦 Schritt 7 – Archiv erstellen

```bash
tar czvf plesk-backup-complete.tar.gz /root/plesk-backup
```

---

## ☁️ Schritt 8 – Optional: Upload auf externen Server

```bash
scp plesk-backup-complete.tar.gz user@backup-server:/backups/
```

---

## ♻️ Wiederherstellung nach Neuinstallation

Nach Neuinstallation von AlmaLinux + Plesk:

```bash
# Lizenz aktivieren (optional)
plesk bin license --install

# Server-Backup einspielen
plesk restore plesk-dump/full-server-backup.tar -level server
```

Alternativ: einzelne Kunden/Websites/DBs wiederherstellen:

```bash
plesk restore <backup-file> -level client
```

---

## ✅ Zusammenfassung

| 🔧 Komponente     | 📦 Backup-Methode                  | ♻️ Wiederherstellung |
|------------------|------------------------------------|----------------------|
| Plesk-Accounts   | `pleskbackup`                      | ✔️ GUI/CLI          |
| MariaDB          | `mysqldump` + Pleskbackup          | ✔️ manuell/Plesk     |
| Websites         | `/var/www/vhosts`                  | ✔️ manuell           |
| E-Mails          | `/var/qmail`, `/var/mailnames`     | ✔️ manuell           |
| Configs          | `/etc/*` sichern                   | ✔️ manuell/anpassen  |

---

## 📘 Hinweise

- Das Tutorial wurde auf einem typischen CentOS-7-Server mit Plesk Obsidian getestet.
- Für den produktiven Einsatz empfiehlt sich ein Test auf einem parallelen Testsystem vor der finalen Migration.

---

> Erstellt mit ❤️ für die Community. Feedback & Erweiterungen willkommen!
