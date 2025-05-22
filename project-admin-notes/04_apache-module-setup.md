# 🚀 Plesk Migration: Apache Module Setup auf CentOS

Beim Umzug von Plesk auf einen neuen CentOS-Server können folgende Hinweise in den Logs auftauchen:

---

### ⚠️ Fehlende Apache-Module

The following Apache modules are not installed on the destination server: file_cache, lua, perl.
Please install and turn on these modules in Plesk to prevent some possible problems.
The component mod_perl is not installed on the destination server.

### ⚠️ Deaktivierte Apache-Module

The following Apache modules are disabled on the destination server: speling, sysenv, usertrack.
Please turn on these modules in Plesk to prevent some possible problems.

---

## 🔧 Lösungsschritte für CentOS

### 1️⃣ Module installieren

```bash
sudo yum install httpd mod_perl mod_lua

    - file_cache ist Teil von mod_cache, das bei CentOS meist vorinstalliert ist.

    - Falls mod_cache fehlt, zusätzlich installieren:

sudo yum install mod_cache
```

### 2️⃣ Module aktivieren

Auf CentOS sind Apache-Module oft automatisch aktiv nach Installation. Um sicherzugehen, kann man in der Konfigurationsdatei /etc/httpd/conf.modules.d/ prüfen, ob folgende Zeilen vorhanden und nicht auskommentiert sind:

```bash
LoadModule lua_module modules/mod_lua.so
LoadModule perl_module modules/mod_perl.so
LoadModule speling_module modules/mod_speling.so
LoadModule usertrack_module modules/mod_usertrack.so
```

### 3️⃣ Apache neu starten

```bash
sudo systemctl restart httpd
```

### 4️⃣ Plesk Web-Oberfläche

Unter Tools & Einstellungen → Apache-Webserver (oder ähnliche Einstellung) prüfen, ob Module aktiviert sind.

Fehlermeldungen erneut prüfen.

### ✅ Checkliste vor und nach Migration
[ ] Apache-Module wie oben beschrieben installieren und aktivieren

[ ] Apache neu starten

[ ] Plesk-Server prüfen

[ ] Webseiten testen (funktionieren sie wie vorher?)

[ ] Logs auf Fehler überprüfen

### ℹ️ Hinweis

- mod_perl wird nur benötigt, wenn Websites oder Plesk-Objekte Perl-Unterstützung benötigen.

- Wenn file_cache oder andere Module auf dem Quellserver genutzt wurden, sollten sie auch auf dem Zielserver vorhanden sein, um Funktionsprobleme zu vermeiden.

- Wenn bestimmte Module nicht benötigt werden, können sie deaktiviert bleiben, aber das sollte bewusst entschieden werden.

---

Bei Fragen oder Problemen gerne melden! 🚀

Erstellt mit ❤️ für einfache und sichere Plesk Migration auf CentOS