# 📦 Multi-Node.js-Setup unter Plesk

> Ermögliche mehreren Domains oder Projekten auf deinem Plesk-Server die Verwendung verschiedener Node.js-Versionen (z. B. 16.x, 18.x, 20.x, 22.x).

---

## 🔍 Übersicht

Plesk unterstützt **nur systemweit installierte Node.js-Versionen** – keine Node-Manager wie `nvm` oder `nodenv`. Damit du flexibel verschiedene Versionen anbieten kannst, sind folgende Methoden möglich:

---

## 🚀 Methode A – Manuelle Installation pro Version

Diese Methode installiert Node.js-Versionen in einem systemweiten Pfad wie `/opt/plesk/node/<version>/`.

### ✅ Vorteile

* Kompatibel mit Plesk-Dropdown für Node-Versionen
* Klare Struktur und kein Eingriff in laufende Umgebungen

### 🛠️ Schritte

```bash
mkdir -p /opt/plesk/node/16
cd /opt/plesk/node/16
curl -O https://nodejs.org/dist/v16.20.2/node-v16.20.2-linux-x64.tar.xz
tar -xf node-v16.20.2-linux-x64.tar.xz --strip-components=1

# Optional: Symlink für manuellen Zugriff
ln -s /opt/plesk/node/16/bin/node /usr/local/bin/node16
ln -s /opt/plesk/node/16/bin/npm /usr/local/bin/npm16
```

🔁 **Wiederhole dies** für weitere Versionen:

* `/opt/plesk/node/18` → `v18.20.8`
* `/opt/plesk/node/20` → `v20.19.2`
* `/opt/plesk/node/22` → `v22.16.0`

> 💡 Du kannst danach in Plesk pro Domain die gewünschte Version auswählen.

---

## 🧪 Methode B – Nutzung von `nodenv` (nur indirekt empfohlen)

`nodenv` erlaubt die parallele Nutzung mehrerer Node-Versionen pro Benutzer. Diese Methode ist **nicht direkt Plesk-kompatibel**, kann aber über Symlinks "vorgespiegelt" werden.

### 🔧 Beispiel

```bash
ln -s ~/.nodenv/versions/22.16.0/bin /opt/plesk/node/22/bin
```

> ⚠️ Vorsicht: `nodenv`-basierte Installationen sollten stabil, vollständig und für alle Benutzer verfügbar sein.

---

## 🧩 Optional: Integration in Plesk

Wenn die Node.js-Versionen installiert wurden, erkennt Plesk sie meist automatisch. Falls nicht:

* Prüfe `/opt/plesk/node/` in der Plesk-Konfiguration
* Nutze Umgebungsvariablen (z. B. über `.bashrc`, `.bash_profile` oder `.profile`)

---

## 🛡️ Sicherheits- und Wartungshinweise

* 🔐 Achte auf aktuelle Versionen mit Sicherheitsupdates
* 🔄 Führe regelmäßige Updates durch (`npm audit fix` etc.)
* 🧼 Verwende klare Pfade und Symlinks zur besseren Wartbarkeit

---

## 📚 Weitere Ressourcen

* [Node.js Downloads](https://nodejs.org/en/download/releases)
* [Plesk Dokumentation (Node.js Extension)](https://docs.plesk.com/en-US/obsidian/administrator-guide/web-hosting/node-js-support.79382/)


