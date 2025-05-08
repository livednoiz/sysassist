# 🛡️ Fail2Ban & IP-Management – Automatisierter Schutz vor Brute-Force-Angriffen

Fail2Ban ist ein essenzielles Sicherheits-Tool für Linux-Systeme, das Logdateien nach verdächtigen Login-Versuchen durchsucht und automatisch IP-Adressen blockiert, die sich zu oft falsch anmelden. In Kombination mit Whitelists und Blacklists sorgt es für effektiven Grundschutz – besonders im SSH-Bereich.

## 🔧 Funktionen im Überblick

* 🔍 **Überwachung von Logdateien** (z. B. /var/log/auth.log)
* 🚫 **Automatisches Sperren** bösartiger IP-Adressen via `iptables` oder `firewalld`
* ✅ **Whitelist-Management**: Bestimmte IPs dauerhaft freigeben
* ❌ **Blacklist-Management**: Bekannte Angreifer sofort sperren
* 🧠 **Anpassbare Filter** für verschiedene Dienste (z. B. SSH, Postfix, Dovecot)

## ⚙️ Automatisierungsvorschläge

* 📝 **Konfigurationsskript** zur Einrichtung und Aktivierung von Fail2Ban samt Logging
* ⏱️ **Cronjob oder Systemd-Timer** zur regelmäßigen Auswertung und Bereinigung von Bans
* 📥 **Integration mit Benachrichtigungssystemen**: Telegram, Matrix oder Mail bei neuen Sperren

## 📂 Projektstruktur (Beispiel)

```
fail2ban_setup/
├── setup_fail2ban.sh          # Automatisiertes Installations- und Konfigurationsskript
├── jail.local                 # Beispielkonfiguration
├── ip_whitelist.txt           # Liste sicherer IPs
├── ip_blacklist.txt           # Liste gesperrter IPs
└── logs/
    └── fail2ban_setup.log     # Setup- und Aktivitätslog
```

## 📌 Weiterführende Ideen

* 🌐 GeoIP-Blocking (nur Login-Versuche aus bestimmten Ländern zulassen)
* 📊 Übersichtsskript für gebannte IPs mit Count & Timestamps
* 🤖 Anbindung an Threat Intelligence Feeds zur automatisierten Blacklist-Erweiterung
