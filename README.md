# 🛠️ SysAssist

```
   _____           _____        _     _     _     
  / ____|         / ____|      | |   (_)   | |    
 | (___  _   _   | (___    ___ | |__  _  __| | ___
  \___ \| | | |   \___ \  / _ \| '_ \| |/ _` |/ _ \
  ____) | |_| |   ____) || (_) | |_) | | (_| |  __/
 |_____/ \__, |  |_____/  \___/|_.__/|_|\__,_|\___|
          __/ |                                    
         |___/        Smart Admin Toolkit for Plesk
```

---

**SysAssist** ist dein smarter Helfer für Linux-Server mit **Plesk**, **MariaDB** und modernen Anforderungen wie Migrationen (z. B. CentOS 7 → AlmaLinux 8).  
Ein Muss für Admins mit Verantwortung – auch ohne formale Ausbildung.

---

## 🚀 Features

- ✅ **Backup & Recovery** für Plesk, MariaDB und Benutzerdaten
- 🔍 **Pre-Migration Checks** für Repositories & Paketkonflikte
- 🧹 **Modular & Transparent**: Jede Funktion als eigenes Shellscript
- 📄 **.env-Support**: Einfache Anpassung ohne manuelles Editieren von Scripts
- 📖 **Markdown-Dokumentation** für jeden Schritt
- 🤖 Geplant: Interaktiver Modus für komplexe Migrationen wie `centos2alma`

---

## 📦 Schnellstart

```bash
git clone https://github.com/deinuser/sysassist.git
cd sysassist
cp .env.example .env
nano .env      # Passe deine Umgebung an
./backup.sh    # Starte z. B. das Backup-Modul
```

Weitere Anleitung zur vollständigen Plesk-Migration und Datensicherung findest du in der [tutorial.md](./tutorial.md).

---

## 📁 Modulübersicht

| Modul             | Status   | Beschreibung                             |
|-------------------|----------|------------------------------------------|
| `backup.sh`       | ✅ Stable | Vollständiges Backup für Plesk & MariaDB |
| `check_env.sh`    | ⚙️ Beta   | Systemprüfung für EL7 → EL8 Migration     |
| `convert.sh`      | 🧪 Alpha  | Vorbereitung centos2alma                 |
| `restore.sh`      | ⏳ Planung | Restore-Workflow für neues Zielsystem    |

---

## 🎯 Zielgruppe

> Dieses Tool ist für Sysadmins, Hoster, DevOps oder Quereinsteiger –  
> alle, die Verantwortung für Linux-Systeme tragen (müssen oder wollen).

Geeignet für:
- 🧑‍💻 Linux-Admins mit SSH-Zugang
- 🧠 Quereinsteiger mit Lernwille
- 🧰 Hoster, die Plesk nicht nur klicken
- 🪛 Freelancer mit Root-Verantwortung

---

## 🔐 Sicherheit & Transparenz

- Keine versteckten Prozesse – alles Bash, alles offen.
- `.env` sorgt für klar definierte Werte (z. B. Backup-Pfade, Domains).
- Geplant: Checksums, Lockfiles und Restore-Validierung.

---

## 🧪 Entwicklung & Beiträge

> Du hast Ideen oder willst mitarbeiten? Pull Requests willkommen!  
> Forke das Repo oder eröffne ein Issue für deinen Vorschlag.

---

## 📜 Lizenz

MIT – Du darfst alles, solange du den ursprünglichen Hinweis belässt.  
**Verantwortung bleibt bei dir.**

---

## 🦮 Unterstütze das Projekt

Wenn dir **SysAssist** hilft, teile es mit anderen Admins.  
Oder bring deine eigenen Module ein – ganz im Open-Source-Geist.

---

> 🤖 **SysAssist** macht aus Chaos Struktur. Und aus Admins smarte Macher.
