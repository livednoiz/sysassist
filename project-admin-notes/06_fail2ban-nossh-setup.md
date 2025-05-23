# 🛡️ Fail2Ban Absicherung für Plesk-Server (ohne SSH)

Willkommen zu einer erweiterten Konfiguration von **Fail2Ban** für Plesk-Server, bei denen der SSH-Zugang deaktiviert ist. Diese Anleitung zeigt dir, wie du dein System gegen gängige Angriffsvektoren absicherst und dabei wichtige Dienste wie Mail, FTP und das Plesk-Panel schützt.

---

## 📂 Inhalt

* 🔒 Wichtige Jails
* ⚙️ Beispielkonfigurationen
* 🚀 Einrichtung & Neustart
* 🧪 Prüfung & Monitoring

---

## 🔒 Wichtige Jails für Plesk

### 🌐 `plesk-login`

Schützt das Plesk Webinterface vor Brute-Force-Angriffen.

```ini
[plesk-login]
enabled = true
filter  = plesk-login
port    = http,https
logpath = /var/log/plesk/panel.log
maxretry = 5
findtime = 600
bantime  = 3600
```

---

### 📬 `postfix`

Sichert den SMTP-Server gegen Login-Angriffe ab.

```ini
[postfix]
enabled = true
port    = smtp,ssmtp,submission
filter  = postfix
logpath = /var/log/maillog
maxretry = 5
```

---

### 📨 `dovecot`

Schützt IMAP und POP3 gegen wiederholte Loginversuche.

```ini
[dovecot]
enabled = true
port    = pop3,pop3s,imap,imaps
filter  = dovecot
logpath = /var/log/maillog
maxretry = 5
```

---

### 💻 `roundcube-auth`

Optional: Absicherung des Roundcube Webmail-Logins.

```ini
[roundcube-auth]
enabled = true
filter  = roundcube-auth
port    = http,https
logpath = /var/log/maillog
maxretry = 5
```

---

### 🔐 `plesk-apilogin`

Blockiert missbräuchliche API-Zugriffe auf Plesk.

```ini
[plesk-apilogin]
enabled = true
filter  = plesk-apilogin
logpath = /var/log/plesk/panel.log
port    = http,https
maxretry = 5
```

---

### 📁 `proftpd` (oder vsftpd / pure-ftpd)

Schützt FTP-Dienste vor Brute-Force-Angriffen.

```ini
[proftpd]
enabled = true
port    = ftp
filter  = proftpd
logpath = /var/log/secure
maxretry = 5
```

---

### ♻️ `recidive`

Langfristiger Bann für Wiederholungstäter über mehrere Jails hinweg.

```ini
[recidive]
enabled = true
logpath = /var/log/fail2ban.log
bantime  = 86400
findtime = 86400
maxretry = 5
```

---

## ⚙️ Einrichtung & Neustart

Nach dem Hinzufügen der Konfigurationen in `jail.local`:

```bash
sudo systemctl restart fail2ban
```

---

## 🧪 Statusprüfung

Jail-Status anzeigen:

```bash
sudo fail2ban-client status
```

Details zu einem Jail:

```bash
sudo fail2ban-client status plesk-login
```

---

## 🧰 Tipps

* Entferne `[sshd]` falls SSH deaktiviert ist
* Verwende passende Filter (liegen meist unter `/etc/fail2ban/filter.d/*.conf`)
* Setze Banzeiten und Findtimes je nach gewünschter Härte

---

> 🚨 **Hinweis:** Du kannst zusätzlich Firewall-Regeln definieren, um externe Ports weiter zu beschränken. Fail2Ban ist ein reaktives Schutzsystem – es ersetzt keine Härtung des Gesamtsystems.

---

## 🧠 Lizenz & Mitmachen

Dies ist Teil von `sysassist`, einem offenen Projekt zur Systemadministration.

📝 Lizenz: MIT

👥 Pull Requests & Mitstreiter willkommen!

---

# 🛡️ Fail2Ban Setup unter AlmaLinux 9

Sicherer Serverbetrieb beginnt mit der effektiven Absicherung gegen Brute-Force-Angriffe. Dieses Dokument beschreibt die Installation und Konfiguration von **Fail2Ban** unter **AlmaLinux 9**, speziell mit Fokus auf den SSH-Dienst.

---

## 🔧 1. Installation

```bash
sudo dnf install epel-release -y
sudo dnf install fail2ban -y
```

> 💡 Fail2Ban ist im EPEL-Repository enthalten.

---

## 📁 2. Konfigurationsverzeichnis prüfen

```bash
ls /etc/fail2ban
```

Wichtige Dateien:

* `jail.conf` (nicht direkt bearbeiten)
* `jail.local` (eigene Konfigurationen)
* `filter.d/` (Filterdefinitionen für Dienste)

---

## 📝 3. jail.local erstellen

```bash
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
```

### Beispiel-Konfiguration:

```ini
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5
backend = systemd

[sshd]
enabled = true
port    = ssh
filter  = sshd
logpath = %(sshd_log)s
```

> 🔐 Aktiviert den SSH-Schutz mit systemd-Backend

---

## 🚦 4. Dienst starten & aktivieren

```bash
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo systemctl status fail2ban
```

---

## 📊 5. Status & Überwachung

```bash
sudo fail2ban-client status sshd
```

Zeigt aktuell gebannte IPs und Status des SSH-Jails.

---

## 🧱 6. Firewall-Integration (optional)

```bash
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
```

---

## ⚙️ 7. SELinux-Kompatibilität (optional)

Falls Fail2Ban durch SELinux blockiert wird:

```bash
sudo semanage permissive -a fail2ban_t
```

---

## 🧰 8. Weitere Dienste absichern

Fail2Ban kann erweitert werden, um weitere Dienste wie z. B. **Apache**, **Dovecot**, **Plesk** oder **Postfix** zu schützen. Filter findest du in:

```bash
/etc/fail2ban/filter.d/
```

---

## 📌 Hinweis zur SSH-Konfiguration

Wenn Plesk-Migration oder Admin-Zugang über SSH erfolgen soll, muss in `/etc/ssh/sshd_config` vorübergehend folgendes aktiviert sein:

```ini
PermitRootLogin yes
PasswordAuthentication yes
```

Nach erfolgreicher Migration können diese wieder auf `no` gesetzt und SSH ggf. deaktiviert oder durch Fail2Ban abgesichert werden.

---

> 🚀 Bereit für sicheres Server-Hosting mit Fail2Ban!

---

**Nächster Schritt:** Erweiterung des jail.local um weitere Dienste und automatische Bann-Benachrichtigungen via E-Mail 📧

---

🛠️ Erstellt mit ❤️ für Server-Sicherheit
