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

🛠️ Erstellt mit ❤️ für Server-Sicherheit
