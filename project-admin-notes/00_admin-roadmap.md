# 🛠️ Plesk Server Setup & Engineering Roadmap

Willkommen zur Roadmap für die vollständige und sichere Konfiguration eines Plesk-Servers unter AlmaLinux 9 mit erweiterten Entwickler-Tools und Sicherheitsfunktionen. Diese Checkliste führt dich Schritt für Schritt durch alle relevanten Maßnahmen.

---

## ✅ Abgehakt

### 🔌 Apache Module Konfiguration

* [x] Fehlende Module installiert: `mod_perl`, `mod_lua`, `mod_cache`
* [x] Deaktivierte Module aktiviert: `speling`, `sysenv`, `usertrack`

---

## 🛡️ Als nächstes: Sicherheit einrichten

### 🔐 Fail2Ban Setup

* [ ] Konfiguration der `jail.local`
* [ ] Filter-Regeln prüfen & anpassen
* [ ] Services absichern: Plesk-Panel, Webmail, Apache, evtl. Mailserver
* [ ] SSH Jail ggf. weglassen (SSH deaktiviert)

---

## 🧩 Node.js Multi-Version Umgebung

### 📦 nodeenv Integration

* [ ] Installation von `nodeenv`
* [ ] Bereitstellung folgender NodeJS-Versionen:

  * [ ] v16.20.2
  * [ ] v18.20.8
  * [ ] v20.19.2
  * [ ] v22.16.0
* [ ] Erstellung eines Automatisierungsskripts (Download, Entpacken, Verlinken)
* [ ] Integration in Plesk Dropdown

---

## 🐍 Python Umgebung

### 🧰 pyenv & virtualenv

* [ ] Installation `pyenv`
* [ ] Mehrere Python-Versionen bereitstellen
* [ ] Integration von `virtualenv`, `setuptools`, `pip`
* [ ] Systemweite Umgebung + Benutzerkonfiguration

---

## 💙 Flutter Entwicklungsumgebung

### 📱 Flutter SDK Setup

* [ ] Installation Flutter SDK (aktuelle stable Version)
* [ ] Einrichtung PATH & Ausführungsrechte
* [ ] Android SDK optional (für Mobile Builds)
* [ ] `flutter doctor` Test durchführen
* [ ] Integration via pyenv/VSCode/Plesk-Shell vorbereiten (je nach Bedarf)

---

## ⚙️ Weitere geplante Schritte (optional)

* [ ] Hardened Kernel Module prüfen
* [ ] Fail2Ban Erweiterung mit GeoIP
* [ ] Docker-Umgebung in Plesk konfigurieren
* [ ] Containerisierte Deployments (Node/Python)
* [ ] Automatisierte Backups (lokal & remote)
* [ ] Git-basierte CI/CD-Pipeline über Plesk Webhooks

---

📌 **Hinweis:** Diese Roadmap wird fortlaufend ergänzt. Melde dich bei Bedarf für neue Module, Dienste oder geplante Integrationen.

---

🧠 *Stay curious, stay secure!* 🚀
