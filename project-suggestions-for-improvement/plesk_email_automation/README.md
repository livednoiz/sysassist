# 📧 Automatische E-Mail-Konfiguration mit Plesk

Diese Anleitung beschreibt, wie du mit Plesk die automatische Einrichtung von E-Mail-Clients wie Thunderbird, Outlook und Apple Mail ermöglichst – ganz ohne manuelles Eingeben von Serverdaten.

---

## ✅ Ziel

🔹 **E-Mail-Clients wie Thunderbird, Outlook & Apple Mail sollen automatisch Serverdaten erkennen**
🔹 **Vermeidung manueller Konfiguration durch Endnutzer**

---

## 🛠 Voraussetzungen

* Aktives Webhosting mit **Plesk**
* Mailserver (z. B. **Postfix + Dovecot**) über Plesk aktiv
* Webmail wie **Roundcube** aktiviert

---

## 📌 Schritt-für-Schritt-Anleitung

### 1. 🔧 Autodiscover in Plesk aktivieren

* Navigiere zu `Tools & Einstellungen → Mailserver-Einstellungen`
* Aktiviere (sofern vorhanden) die Option **"Autodiscover-Unterstützung"**

### 2. 🌐 DNS-Einträge für Autodiscover setzen

| Typ   | Hostname                          | Ziel                              |
| ----- | --------------------------------- | --------------------------------- |
| A     | autoconfig.example.com            | IP-Adresse deines Webservers      |
| A     | autodiscover.example.com          | IP-Adresse deines Webservers      |
| CNAME | \_autodiscover.\_tcp.example.com  | autodiscover.example.com.         |
| SRV   | \_autodiscover.\_tcp.example.com. | 0 0 443 autodiscover.example.com. |

> 🔁 *DNS-Änderungen können bis zu 24 Stunden brauchen, bis sie weltweit aktiv sind.*

### 3. 🔁 Weiterleitungen in Apache/Nginx sicherstellen

Wenn Plesk nicht automatisch leitet, manuell ergänzen:

```apacheconf
Redirect /autodiscover/autodiscover.xml https://webmail.example.com/autodiscover/autodiscover.xml
```

> 🧠 *Dies kann in der Apache-Konfiguration oder per `.htaccess` in der Domain-Root geschehen.*

### 4. 📄 Pfade zur Autokonfigurationsdatei

* Thunderbird erwartet: `https://autoconfig.example.com/mail/config-v1.1.xml`
* Outlook & Apple Mail erwarten: `https://autodiscover.example.com/autodiscover/autodiscover.xml`

---

## 🍏 Unterstützung für Apple Mail (macOS & iOS)

Apple Mail verwendet dieselbe Autodiscover-Methode wie Microsoft Outlook:

🔸 **Versuch über `autodiscover.example.com/autodiscover/autodiscover.xml`**
🔸 **Fallback auf Root-Domain (`example.com`) falls kein Subdomain-Eintrag existiert**
🔸 **Verwendung von DNS-SRV `_autodiscover._tcp.example.com` als letzte Option**

📁 **Pfad zur Datei:**

```
https://autodiscover.example.com/autodiscover/autodiscover.xml
```

> ⚠️ Diese Datei muss das Outlook-kompatible XML-Schema verwenden – kein separates Apple-Format notwendig.

---

## 🧪 Testen deiner Konfiguration

Nutze diese Tools:

* [🔍 Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/)
* [🕊 Thunderbird Autoconfig Tester](https://autoconfig.thunderbird.net/)

---

## 💡 Optional: Eigene XML für Thunderbird bereitstellen

Speichere deine eigene Konfigurationsdatei unter:

```bash
/var/www/vhosts/example.com/httpdocs/.well-known/autoconfig/mail/config-v1.1.xml
```

Stelle sicher, dass der Webserver Anfragen auf diese Datei korrekt ausliefert.

---

## 📝 Notiz: Automatisierung der DNS-Einträge für mehrere Domains

Dieser Abschnitt wird derzeit recherchiert und wird daher später bearbeitet, um ein reibungslose Multidomain-Setup realisieren zu können.