# 🛠️ Cockpit Web GUI Setup für AlmaLinux 9

> **Moderne Serververwaltung im Browser – für Admins und Noobs**

---

## 🔍 Was ist Cockpit?

Cockpit ist eine Web-basierte Verwaltungsoberfläche für Linux-Server.

* Greifbar unter `https://<server-ip>:9090`
* Ressourcenarm & sicher
* Ideal für Admins ohne tiefes CLI-Wissen
* Erweiterbar durch Module (z.B. KVM, Docker, LVM)

---

## 📦 Installation (AlmaLinux 9)

```bash
sudo dnf install cockpit -y
sudo systemctl enable --now cockpit.socket
```

Dann im Browser aufrufen:

```
https://<deine-server-ip>:9090
```

Login mit einem systemweiten Benutzer (z. B. `root` oder einem mit `sudo`-Rechten).

---

## 🔐 Sicherheit & Zugang

* ✅ TLS-Unterstützung ab Werk
* ❌ Nicht öffentlich zugänglich lassen (verwende VPN oder IP-Firewall)
* 🔐 Optionale Integration mit Let's Encrypt

> **Empfohlene Absicherung:**
>
> • Zugang auf bestimmte IPs beschränken (`firewalld`, `iptables` oder Cloud-Firewall)<br>
> • Reverse Proxy mit NGINX + Basic Auth oder Client-Zertifikat<br>
> • Nutzung innerhalb eines internen Netzwerks oder VPN

---

## ⚙️ Erweiterbare Module

```bash
# KVM Virtualisierung
sudo dnf install cockpit-machines -y

# Storage-Management
sudo dnf install cockpit-storaged -y

# SELinux-Modul
sudo dnf install cockpit-selinux -y
```

Weitere Module findest du unter: [https://cockpit-project.org/applications.html](https://cockpit-project.org/applications.html)

---

## 📊 Funktionen im Überblick

| Funktion                | Beschreibung                                 |
| ----------------------- | -------------------------------------------- |
| 🔋 System-Status        | CPU, RAM, Disk, Netzwerk – live & historisch |
| 📅 Updates & Pakete     | DNF-gesteuerte GUI für Upgrades              |
| 🔒 Benutzerverwaltung   | Add/Edit/Remove mit GUI                      |
| 🏠 Netzwerk-Tools       | IP, DNS, Gateway, Bonding etc.               |
| 📊 Journal Logs         | `journalctl` im Browser                      |
| ⚙️ Diensteverwaltung    | `systemd`-Services starten/stoppen/restarten |
| 🌌 Terminal-Emulation   | SSH im Browser                               |
| 🚘 Multi-Host Dashboard | Andere Server verbinden und verwalten        |

---

## 🆚 Vergleich mit Desktop-GUI

| Kriterium           | Cockpit ✅ | GNOME/KDE ❌              |
| ------------------- | --------- | ------------------------ |
| Ressourcenverbrauch | Niedrig   | Hoch                     |
| Sicherheit          | Hoch      | Geringer (offene Ports)  |
| Zugriff via Browser | Ja        | Nein                     |
| Terminal integriert | Ja        | Nein (nur extra App)     |
| Geeignet für Server | ✅ Ja      | ❌ Nein (nicht empfohlen) |

---

## 🖥️ iDRAC 8 (Integrated Dell Remote Access Controller)

Dell iDRAC ist eine Hardware-Firmware-Lösung für Out-of-Band-Management von Dell Enterprise-Servern.

### 🔧 Nutzungsszenario

Ideal für Headless-Server oder Remote-Access in Rechenzentren. iDRAC funktioniert unabhängig vom Betriebssystem.

### 🧩 iDRAC 8 GUI Basics

* Zugriff über: `https://<server-ip>` (ggf. dedizierte Management-IP nutzen)
* Login über voreingestellten Benutzer (z. B. `root` / `calvin`, sofern nicht geändert)

### ❗ Hinweis: Fehlermeldung `RAC0690`

> *„Auf dem Betriebssystem des Servers ist kein iDRAC Service Module installiert…“*

Das bedeutet:

* Das optionale **iDRAC Service Module (iSM)** ist nicht auf dem OS installiert.
* Installation ermöglicht z. B.:

  * Zugriff auf OS-spezifische Telemetrie (Netzwerk, Logs, Sensors)
  * Kommunikation zwischen OS und iDRAC-Interface

### 📥 iSM Installation (für AlmaLinux 9)

1. Dell-Repo hinzufügen:

```bash
sudo dnf config-manager --add-repo=https://linux.dell.com/repo/hardware/dsu/os_dependent/
```

2. iSM-Paket installieren:

```bash
sudo dnf install srvadmin-idracadm8 -y
```

3. Service starten:

```bash
sudo systemctl start dataeng
sudo systemctl enable dataeng
```

Danach sollte die Warnung im iDRAC verschwinden und zusätzliche OS-Infos werden abrufbar.

---

## 📁 Weitere Ressourcen

* 🔗 [https://cockpit-project.org](https://cockpit-project.org)
* 📃 [GitHub Repo](https://github.com/cockpit-project/cockpit)
* 💡 Dokumentation: `man cockpit`, `man cockpit-ws`
* 💻 Dell iDRAC Guide: [https://www.dell.com/support](https://www.dell.com/support)

---

## 🙌 Empfehlung

Cockpit ist die perfekte Brücke für Einsteiger, Admins mit GUI-Präferenz oder Remote-Support. In Kombination mit iDRAC erhältst du maximale Kontrolle über Soft- **und** Hardware – browserbasiert, sicher und ressourcenschonend.

---

> Bei Fragen zur Härtung, Multi-Server-Ansicht oder erweiterten Monitoring-Anbindung (Zabbix, Grafana etc.) melde dich jederzeit!
