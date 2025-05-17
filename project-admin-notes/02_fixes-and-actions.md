# ✨ Plesk + Let's Encrypt Zertifikatsprobleme nach Serverwechsel

## 🔍 Problemübersicht

Wenn eine Domain zuvor auf einem anderen Server betrieben wurde und dort Let's Encrypt-Zertifikate ausgestellt wurden, kann es bei einem Serverwechsel zu Problemen kommen. Insbesondere Plesk hat Schwierigkeiten, neue Zertifikate bereitzustellen, wenn:

* ✖️ Alte Zertifikatsinformationen noch lokal oder in Plesk gespeichert sind
* ✖️ Zertifikatsanforderungen durch Let’s Encrypt aufgrund von Rate Limits blockiert werden
* ✖️ HTTP-Challenges fehlschlagen, z. B. durch falsche Weiterleitungen oder DNS-Probleme

## ❓ Warum passiert das?

Let's Encrypt selbst speichert keine "blockierenden" Daten, aber Plesk speichert Domain-bezogene Zertifikatseinträge und alte Konfigurationsreste, die den Erneuerungsprozess behindern. Die Folge:

* Fehlerhafte oder nicht durchführbare Anfragen an Let's Encrypt
* Zertifikate können nicht neu erstellt oder importiert werden
* Die Webseite zeigt Sicherheitswarnungen an

---

# 🔧 Lösung: Zertifikate in Plesk sauber neu ausstellen

## 🏋️ Schritt-für-Schritt-Anleitung

### ✅ **1. Rate Limits prüfen**

Bevor du etwas löschst, stelle sicher, dass du nicht von einem Let's Encrypt Rate Limit betroffen bist:

* → [https://tools.letsdebug.net](https://tools.letsdebug.net)
* → [Let's Encrypt Rate Limits](https://letsencrypt.org/docs/rate-limits/)

### ♻️ **2. Alte Zertifikatsdateien manuell entfernen**

Auf dem Server (Root-Zugriff erforderlich):

```bash
rm -rf /etc/letsencrypt/live/example.com
rm -rf /etc/letsencrypt/archive/example.com
rm -f /etc/letsencrypt/renewal/example.com.conf
```

> 🚨 **Achtung**: Ersetze `example.com` durch deine echte Domain!

### ⚙️ **3. Plesk reparieren und neu konfigurieren**

Nutze Plesk's eigene Tools zur Fehlerbehebung:

```bash
plesk repair web example.com
plesk repair mail example.com
plesk repair all -y
```

### 🔑 **4. Neues Zertifikat über Plesk anfordern**

Im Plesk-Webinterface:

1. Navigiere zu **Websites & Domains**
2. Wähle die betroffene Domain
3. Klicke auf **Let's Encrypt**
4. Fordere ein neues Zertifikat an

### ✨ **5. (Optional) Zertifikat mit DNS-Challenge erzwingen**

Wenn HTTP-basierte Verifikation fehlschlägt:

```bash
certbot certonly --manual --preferred-challenges dns -d example.com -d www.example.com
```

Anschließend kann das Zertifikat in Plesk importiert werden.

---

## 📄 Bonus: Aktuelle Zertifikate anzeigen

```bash
certbot certificates
/usr/local/psa/admin/bin/ssl_certificates --info
```

---

## 📊 Fazit

* Let's Encrypt blockiert nicht aktiv neue Zertifikate durch alte Einträge
* Plesk speichert jedoch Informationen, die Probleme verursachen können
* Durch manuelles Entfernen, Reparatur und Neuinstallation lässt sich das Problem schnell beheben

> ✨ **Tipp**: Nutze DNS-01-Challenges für maximale Kontrolle, insbesondere wenn HTTP-Verifizierung durch Weiterleitungen oder alte Konfigurationen gestört ist.

---

Maintainer: [Sascha Gebel]
Letztes Update: Mai 2025
