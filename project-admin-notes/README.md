# 🧭 Plesk Server Engineering Roadmap

Willkommen zur strukturierten Roadmap für die umfassende Administration und Absicherung eines Plesk-Servers unter AlmaLinux 9.

Diese Checkliste dient zur Übersicht über die wichtigsten Schritte zur Einrichtung, Absicherung und Erweiterung der Serverumgebung. Jeder Punkt kann bei Erledigung abgehakt werden. ✅

---

## ✅ 1. Apache Module Check & Activation

🔧 *Fehlende Module installieren / aktivieren:*

* [x] `mod_perl`
* [x] `mod_lua`
* [x] `mod_speling`
* [x] `mod_usertrack`
* [x] `mod_sysenv`

---

## ⛓️ 2. Fail2Ban Setup (inkl. SSH-Absicherung)

🔒 *Implementierung der Fail2Ban-Regeln und Konfiguration der jail.local*

* [x] Konfiguration Firewalld Zone Plesk
* [x] Installation und Aktivierung von `fail2ban`
* [x] Konfiguration der `jail.local` mit folgenden aktiven Jails:
  * `sshd`
  * `plesk-panel` 
  * `postfix`
  * `dovecot`
  * `proftpd` *(oder alternativ `vsftpd` / `pure-ftpd`)*
  * `recidive`
* [x] Verwendung von `firewallcmd-rich-rules` als `banaction` für firewalld
* [x] Whitelisting vertrauenswürdiger IPs (`ignoreip`)
* [x] Testen der Jail-Reaktionen (`fail2ban-client`, Log-Auswertung)
* [x] Ergänzende Firewalld-Regeln prüfen oder implementieren

---

## 🟢 3. Node.js Multi-Version Support

🧰 *NodeJS Umgebung für Plesk bereitstellen:*

* [ ] Verzeichnisstruktur in `/opt/plesk/node/` vorbereiten
* [ ] Automatisiertes Bash-Skript zur Installation von:

  * [ ] Node.js `16.20.2`
  * [ ] Node.js `18.20.8`
  * [ ] Node.js `20.19.2`
  * [ ] Node.js `22.16.0`
* [ ] Anpassung Plesk-Umgebungsvariablen für Zugriff über Dropdown

---

## 🐍 4. Python3 Environment (pyenv / virtualenv)

📦 *Mehrere Python-Versionen und Umgebungen ermöglichen:*

* [ ] `pyenv` installieren
* [ ] Python-Versionen via `pyenv install` (z. B. 3.10, 3.11, 3.12)
* [ ] `virtualenv`, `setuptools`, `pipx` einrichten
* [ ] Globale vs. projektspezifische Umgebungen konfigurieren

---

## ⚙️ 5. Weitere sinnvolle Plesk & Server Engineering Aufgaben

🛠️ *Zur langfristigen Wartung & Performanceoptimierung:*

* [ ] Automatisierte Backup-Strategien
* [ ] Logrotate & Journald-Optimierung
* [ ] Firewall-Konzept / SSH Absicherung (z. B. via PermitRootLogin=no)
* [ ] Plesk Extensions prüfen (z. B. Let's Encrypt, Watchdog, Security Advisor)
* [ ] Monitoring einrichten (z. B. Zabbix, Netdata, Prometheus)
* [ ] Ressourcenüberwachung & Autoresponder für Systemzustände
* [ ] Update-Management via dnf-automatic

---

## 📜 Dokumentation & Repositories

📁 *Zentrale Repositories zur Dokumentation & Automatisierung:*

* [ ] `sysassist` GitHub Projekt mit allen Skripten, Templates & Readmes
* [ ] README-Dateien regelmäßig aktualisieren und versionieren

---

🔚 **Ziel:** Ein sicherer, vielseitig einsatzfähiger Server unter Plesk mit moderner Entwicklungsumgebung und maximaler Wartbarkeit. 💪

---

> Bei Fragen oder zur Weiterentwicklung dieser Roadmap: einfach ansprechen! 🧠
