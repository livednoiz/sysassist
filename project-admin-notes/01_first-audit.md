# 🚧 Migration CentOS 7 zu moderner Containerlösung mit Docker 🐳

## 📌 Ausgangslage

CentOS 7 erreicht am **30. Juni 2024** das **Ende seines Lebenszyklus (EOL)**.  
Dies betrifft sicherheitsrelevante Komponenten – u. a.:

- ⚠️ Keine Sicherheitsupdates mehr
- ⚠️ Wichtige Repositories wie **MariaDB** stellen Support ein
- ❌ `centos2alma`-Migration scheitert an Systemvoraussetzungen

➡️ **Dringender Handlungsbedarf** zur Sicherung des laufenden Systems.

---

## 🧭 Ziel der Migration

🔄 Vergleich zweier möglicher Migrationsstrategien:

1. 🧱 **Standard-Migration auf neues Basis-OS**
2. 🐳 **Docker-basierte Containerisierung**

---

## 🧱 Option 1: Standard-Migration

**Vorgehen:**

- Neuinstallation (z. B. AlmaLinux 9)
- Plesk & Dienste manuell migrieren
- Datenbank & Webinhalte rücksichern

**Nachteile:**

- ⏳ Hoher manueller Aufwand
- 🛑 Downtime wahrscheinlich
- 🔁 Keine nachhaltige Verbesserung der Wartbarkeit

---

## 🐳 Option 2: Migration zu Docker-Umgebung

**Vorteile der Containerisierung:**

- 📦 **Saubere Trennung** von Diensten (Plesk, MariaDB, Mail, etc.)
- ♻️ **Wiederholbare Deployments** durch versionierte Images
- 💾 **Backup & Snapshot-Funktionalität** durch Images & Volumes
- 🚀 **Portabilität** und einfache Skalierbarkeit
- 🔒 **Sicherheitsupdates** durch Image-Rebuilds, unabhängig vom Hostsystem

**Bonus:**  
👉 Speicherung von Datenbank-Schemas & Konfigurationen in Git / DockerHub

---

## ⚖️ Vergleich der Ansätze

| Merkmal                | Klassisch               | Docker-basiert          |
|------------------------|-------------------------|--------------------------|
| Sicherheitsupdates     | OS-abhängig             | Image-abhängig           |
| Migration              | manuell, aufwendig      | autom. via Dockerfiles   |
| Wiederherstellung      | komplex, systemweit     | containerisiert, modular |
| Portabilität           | gering                  | hoch                     |
| Wartbarkeit            | eingeschränkt           | flexibel & modern        |
| Testbarkeit            | schwierig               | beliebig möglich         |

---

## ✅ Empfehlung

**Dockerisierung bietet klare Vorteile:**

- ✔️ Zukunftssichere, modulare Systemstruktur
- ✔️ Saubere Trennung von Konfiguration und Daten
- ✔️ Bessere Test- & Rollback-Möglichkeiten
- ✔️ Schnelleres Patch-Management

---

## 🔧 Nächste Schritte (Projektplan-Preview)

1. 🖥️ Zielbetriebssystem wählen (z. B. Debian 12 oder AlmaLinux 9)
2. 🐳 Docker-Architektur definieren (Plesk, MariaDB, Mail, etc.)
3. 📁 Backups & Konfiguration extrahieren
4. 🧪 Test-Container erstellen & validieren
5. 🔄 Produktivmigration durchführen

> 🔜 Im Anschluss folgt eine detaillierte Projektplanung mit Aufgabenverteilung und Zeitrahmen.

---

**Autor:** _[Sascha Gebel]_  
**Projekt:** Plesk-Migration 2025  
**Stand:** 2025-05-02  
