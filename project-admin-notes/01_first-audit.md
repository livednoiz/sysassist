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

# 💻 Alternative Empfehlung: Migration in eine Proxmox Virtualisierungsumgebung (Proxmox VE)

## 🔍 Überblick

Die Migration in eine **Proxmox VE-Infrastruktur** ermöglicht eine nachhaltige und hochflexible Modernisierung aller produktiven Dienste.

Statt nur auf Docker zu setzen, wird hier ein vollständiger **Virtualisierungsstack mit LXC-Containern, VMs und zentralem Storage** genutzt – ideal für professionelle Umgebungen mit zukünftiger Skalierung.

---

## 🧠 Motivation & Vorteile

### 🔁 Flexibler Umzug & Skalierung

* VMs und Container können bei Hardwareproblemen **einfach migriert** werden (auch live möglich)
* Einrichtung von **Clusterlösungen & Hochverfügbarkeit (HA)** möglich

### 📦 Zentrale Dienste konsolidieren

* Docker-Hosts, Datenserver, Plesk-Instanz, Mailserver, Nextcloud etc. in Containern oder VMs bündeln
* 📂 Gemeinsames Storage-Backend mit Backupfunktion (z. B. ZFS, NFS, Ceph)

### 🛡️ Sicherheit & Redundanz

* Trennung der Dienste auf **Netzwerk-, Storage- und Hostebene**
* Schnelle Wiederherstellung via **Snapshots & Backups**
* Automatisierte Replikation möglich

### 📱 Modernes Monitoring & Verwaltung

* Web-UI und **mobile Proxmox App** für Live-Monitoring und Verwaltungszugriff
* Integration mit Tools wie **Grafana**, **Zabbix**, **Portainer**, etc.

---

## 🧱 Architekturidee (Beispiel)

```
Proxmox VE Host
├── VM: Reverse Proxy / Gateway (z. B. NGINX)
├── CT: Docker-Host (Portainer, Plesk, MariaDB, Redis, Mail)
├── CT: Datenserver (z. B. Nextcloud / MinIO)
├── CT: Backupserver (Borg, Restic, PBS)
├── VM: Monitoring & Logging (Prometheus, Grafana, Loki)
└── External Backup: Proxmox Backup Server (optional)
```

---

## ⚙️ Technische Vorteile im Überblick

| Merkmal                      | Docker-only            | Proxmox VE mit Docker     |
| ---------------------------- | ---------------------- | ------------------------- |
| Hardware-Unabhängigkeit      | Teilweise (nur Images) | Vollständig (VM/CT-Umzug) |
| Snapshot- & Backup-Funktion  | Container-spezifisch   | ZFS-/VM-/CT-Snapshots     |
| Monitoring & Logging         | Manuell erweiterbar    | Integrierbar / Mobile App |
| Ausfallsicherheit (HA)       | Nur mit Aufwand        | Cluster-fähig             |
| Datensicherung zentralisiert | Manuell konfigurierbar | PBS, ZFS, NFS, Ceph ready |
| Ressourcenverwaltung         | Container-basiert      | Container + VM mixfähig   |

---

## ✅ Empfehlung: Proxmox VE + Docker + Backupserver

* 🧹 Ideale Plattform für zukünftige Systemerweiterungen
* 🛠️ Lokale oder Cluster-Lösung mit automatisierbaren Deployments
* ☁️ Kombination aus LXC-Containern, Docker & VMs = maximale Flexibilität
* 📲 Monitoring und Verwaltungs-App steigern die Effizienz im Betrieb

---

## 🚀 Nächste Schritte (Projektplan-Preview)

1. 📍 Hardware prüfen & virtualisierungsfähig machen (VT-x/AMD-V, ggf. RAID, ECC-RAM)
2. 💻 Proxmox VE installieren & initial konfigurieren
3. 📁 CT-/VM-Struktur definieren (inkl. Images, Templates & Volumes)
4. 🔄 Testmigration bestehender Dienste
5. 🧪 Live-Testing & Lastverhalten prüfen
6. 📂 Einrichtung von Backupserver & optionalem Monitoring
> 🔜 Im Anschluss folgt eine detaillierte Projektplanung mit Aufgabenverteilung und Zeitrahmen.

---

**Autor:** _[Sascha Gebel]_  
**Projekt:** Plesk-Migration 2025  
**Stand:** 2025-05-02  
