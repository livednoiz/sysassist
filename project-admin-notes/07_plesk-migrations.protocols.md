# 🚀 Plesk-Migration – Netzwerk- & Protokollvoraussetzungen

## 🔍 Überblick

Damit eine Migration zwischen zwei Plesk-Servern erfolgreich durchgeführt werden kann, sind bestimmte Protokolle, Ports und Dienste erforderlich. Diese Anleitung bietet eine Übersicht aller notwendigen Voraussetzungen, um eine reibungslose Migration zu gewährleisten.

---

## 🌐 Benötigte Protokolle & Dienste

| 📡 **Protokoll/Dienst**  | 🔁 **Verbindung** | 🔌 **Port(s)**                              | 🛠️ **Zweck**                                                       |
| ------------------------ | ----------------- | ------------------------------------------- | ------------------------------------------------------------------- |
| **SSH**                  | Quelle → Ziel     | `22/tcp`                                    | Hauptprotokoll für Dateiübertragung & Remote-Kommandos (rsync, scp) |
| **Plesk API (XML/REST)** | Ziel → Quelle     | `8443/tcp`, `8880/tcp`                      | Zugriff auf Plesk-API für Metadaten, Einstellungen, Benutzer usw.   |
| **SMTP (optional)**      | Bidirektional     | `25`, `465`, `587`                          | Transfer von E-Mail-Diensten                                        |
| **POP3/IMAP (optional)** | Bidirektional     | `110`, `995`, `143`, `993`                  | E-Mail-Abruf bei Migration der Postfächer                           |
| **FTP/FTPS (optional)**  | Bidirektional     | `21`, `990` + Datenports                    | Alternativer Dateiimport bei fehlendem SSH-Zugriff                  |
| **Datenbanken**          | Ziel → Quelle     | `3306` (MySQL/MariaDB), `5432` (PostgreSQL) | Direkter DB-Zugriff für Dumps & Strukturkopien                      |
| **DNS (optional)**       | Ziel → DNS        | `53/udp`                                    | DNS-Auflösung, wenn aktiv migriert wird                             |

---

## 🔐 Sicherheit & Konfiguration

* **SSH muss aktiv bleiben**, bis die Migration vollständig abgeschlossen ist.
* `PermitRootLogin` kann auf `yes` oder `without-password` stehen, wenn du z. B. KeyAuth verwendest.
* Alternativ: Temporärer sudo-Zugang für einen Nicht-Root-User.
* **Fail2ban**, **firewalld** oder andere Sicherheitsmechanismen können die Migration behindern, wenn Ports blockiert werden – temporär anpassen!

---

## 🧰 Tools & Hilfsmittel

Stelle sicher, dass folgende Tools auf beiden Servern verfügbar sind:

* `rsync`, `scp`, `tar`, `gzip`
* `mysqldump`, `pg_dump`
* `curl`, `wget`
* `ntpd` oder `chronyd` für Zeit-Synchronisation

---

## ⏳ Zeitplan

> **Hinweis:** SSH-Zugriff darf erst nach erfolgreicher Migration deaktiviert werden!

---

## ✅ Nächste Schritte (Checkliste)

* [ ] Firewall-Regeln für alle benötigten Dienste prüfen
* [ ] SSH aktiviert lassen
* [ ] Root- oder sudo-Zugriff sicherstellen
* [ ] DNS- und Zeit-Synchronisation prüfen
* [ ] Migration via Plesk-Tool starten & überwachen
* [ ] Nach erfolgreichem Transfer: SSH-Absicherung & Deaktivierung

---

🧠 **Merke:** Ohne SSH kein Datenzugriff – Migration **niemals** bei deaktiviertem SSH starten!

---

> 📘 Diese Datei dient als technische Grundlage und sollte während der gesamten Migration zugänglich bleiben.

---

# 🔐 SSH Root Login für Plesk-Migration sicher verwalten

## 📦 Zweck

Diese Anleitung beschreibt die sichere temporäre Aktivierung von `root`-SSH-Zugriff, um eine **Plesk-zu-Plesk-Migration** zwischen zwei Servern erfolgreich durchzuführen.

---

## ⚙️ Voraussetzungen

* Ziel: Migration **kompletter Plesk-Accounts** (inkl. Datenbanken, Domains, Dateien, Einstellungen)
* Protokoll: SSH (standardmäßig über Port `22`)
* Benutzer: `root` oder ein Benutzer mit vollständigen `sudo`-Rechten

---

## 📁 Schritte zur temporären Root-Aktivierung

1. **Öffne die SSH-Konfiguration**:

   ```bash
   nano /etc/ssh/sshd_config
   ```

2. **Ändere oder ergänze folgende Direktive**:

   ```ini
   PermitRootLogin yes
   ```

3. **Lade den SSH-Dienst neu**:

   ```bash
   systemctl reload sshd
   ```

4. ✅ **Führe die Plesk-Migration über das Plesk-Webinterface aus**:

   * Tools & Einstellungen → Migration & Transfer-Manager
   * Ziel-Hostname, Root-Zugangsdaten und SSH-Port angeben

---

## 🛡️ Sicherheitshinweise

> Die dauerhafte Aktivierung von `PermitRootLogin yes` kann ein erhebliches Sicherheitsrisiko darstellen.

**Unmittelbar nach erfolgreicher Migration:**

1. **Deaktiviere den Root-Login wieder**:

   ```ini
   PermitRootLogin no
   ```

2. **Optional: SSH-Port ändern (z. B. auf 2222)**:

   ```ini
   Port 2222
   ```

3. **Aktiviere `Fail2Ban` zur Brute-Force-Abwehr**:

   * Empfohlene Jails: `sshd`, `plesk-login`, `apache-auth`, `recidive`

4. **Lade SSH erneut**:

   ```bash
   systemctl reload sshd
   ```

---

## 🚒 Alternative: Migration ohne Root

Wenn Root-Zugriff nicht erlaubt ist:

* Erstelle einen Benutzer mit `sudo`-Rechten
* Füge ihn zur Datei `/etc/sudoers` hinzu:

  ```bash
  username ALL=(ALL) NOPASSWD:ALL
  ```
* Gib die Zugangsdaten im Migrations-Tool an

**⚠️ Achtung**: Nicht jede Plesk-Version unterstützt Migration mit nicht-root Benutzern vollständig!

---

## ✅ Fazit

> Für reibungslose und vollständige Migrationen ist der `root`-SSH-Zugang temporär erforderlich. Sicherheit und Rücksetzung danach sind entscheidend!

---

**🔐 Sicherheit beginnt nach der Migration – nicht davor!**

