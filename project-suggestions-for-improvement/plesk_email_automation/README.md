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

## 🔪 Automatisierung für mehrere Domains mit Plesk und Autodns

### 📆 Überblick

Wenn du **50 oder mehr Domains** verwalten möchtest, ist es sinnvoll, den Prozess der Autoconfig- und Autodiscover-Integration zu automatisieren. Dies spart viel Zeit und stellt sicher, dass die Konfiguration für alle Domains korrekt und effizient durchgeführt wird. Plesk bietet eine **Autodns-Anbindung**, die dies unterstützt.

---

### 🔄 Schritte zur Automatisierung der Konfiguration

1. **Automatisierung der DNS-Einträge für mehrere Domains**

   * Mit der Autodns-Anbindung von Plesk kannst du automatisch die **SRV- und CNAME-Einträge** für jede Domain erstellen. Ein Skript könnte alle Domains durchlaufen und sicherstellen, dass alle notwendigen DNS-Einträge für Autodiscover und Autoconfig gesetzt sind.
   * Beispiel für **SRV-Einträge**:

     ```
     _autodiscover._tcp.example.com  IN SRV  0  0  443 autodiscover.example.com.
     ```
   * Beispiel für **CNAME-Einträge**:

     ```
     autodiscover.example.com  IN CNAME autodiscover.example.com.
     ```

2. **Automatisierung der `autodiscover.xml` und `autoconfig.xml`-Dateien**

   * Du kannst ein Skript verwenden, um für jede Domain dynamisch die Autodiscover- und Autoconfig-XML-Dateien zu erstellen. Diese Dateien werden im jeweiligen Verzeichnis für jede Domain abgelegt.
   * Beispielhafte Pfade für die Dateien:

     ```
     /var/www/vhosts/example.com/httpdocs/.well-known/autoconfig/mail/config-v1.1.xml
     /var/www/vhosts/example.com/httpdocs/.well-known/autodiscover/autodiscover.xml
     ```

3. **Automatisierung der Weiterleitung in Plesk/Apache**

   * Um sicherzustellen, dass alle Anfragen an die Autodiscover- und Autoconfig-URLs korrekt weitergeleitet werden, kannst du entsprechende **Rewrite-Regeln in Apache** oder **Plesk-Konfigurationen** erstellen.
   * Beispiel für `.htaccess`-Weiterleitung:

     ```apache
     RedirectMatch ^/autodiscover/autodiscover.xml$ /var/www/vhosts/%1/httpdocs/.well-known/autodiscover/autodiscover.xml
     RedirectMatch ^/autoconfig/mail/config-v1.1.xml$ /var/www/vhosts/%1/httpdocs/.well-known/autoconfig/mail/config-v1.1.xml
     ```

4. **Zentrale Verwaltung und Skripting**

   * Ein zentrales Skript könnte alle oben genannten Schritte für jede Domain durchführen. Das Skript könnte auf die Plesk-API zugreifen, um DNS-Einträge zu erstellen, die XML-Dateien zu generieren und sicherzustellen, dass die Weiterleitungen korrekt eingerichtet sind.

5. **Verwendung der Plesk API**

   * Falls du eine präzisere Kontrolle benötigst, kannst du die **Plesk-API** verwenden, um spezifische Aktionen wie **Domain-Verwaltung**, **DNS-Einträge hinzufügen** und **Verzeichnistrukturen** zu automatisieren. Dadurch erhältst du noch mehr Flexibilität bei der Verwaltung vieler Domains.

---

### 📊 Vorteile dieser Lösung

* ✨ **Effizienz**: Du kannst 50 oder mehr Domains in einem einzigen Durchgang konfigurieren, anstatt jede Domain manuell zu bearbeiten.
* ⚖️ **Skalierbarkeit**: Diese Lösung lässt sich leicht erweitern, falls du mehr Domains hinzufügen möchtest.
* ♻️ **Wartungsfreundlichkeit**: Durch die Automatisierung wird der Wartungsaufwand für die Verwaltung der Domains reduziert.
