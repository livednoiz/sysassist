# 🛡️ Fail2Ban Setup mit Firewalld unter AlmaLinux 9 für Plesk

## 🔍 Ziel

Dieses Setup schützt deine Plesk-Umgebung effektiv vor Brute-Force-Angriffen durch Integration von Fail2Ban mit Firewalld. In dieser Konfiguration nutzen wir firewalld statt iptables und aktivieren spezifische Jails für Plesk und Mail-Dienste.

---

## ⚙️ Voraussetzungen

* AlmaLinux 9 mit root-Rechten
* Plesk installiert
* Firewalld aktiviert und läuft

```bash
systemctl enable firewalld --now
```

* Fail2Ban installiert

```bash
dnf install fail2ban -y
```

---

## 📁 Konfigurationspfade

| Komponente         | Pfad                                                                   |
| ------------------ | ---------------------------------------------------------------------- |
| Jail-Konfiguration | `/etc/fail2ban/jail.local`                                             |
| Logfiles           | `/var/log/secure`, `/var/log/maillog`, `/var/log/plesk/panel.log` usw. |

---

## 📥 Installation & Einrichtung

### 1. Fail2Ban aktivieren

```bash
systemctl enable fail2ban --now
```

### 2. Firewalld als banaction definieren

Erstelle oder bearbeite die Datei `/etc/fail2ban/jail.local`:

```ini
[DEFAULT]
banaction = firewallcmd-rich-rules
backend = systemd
findtime = 600
bantime = 86400
maxretry = 5

[sshd]
enabled = true
port = ssh
logpath = /var/log/secure
filter = sshd

[recidive]
enabled = true
logpath = /var/log/fail2ban.log
banaction = firewallcmd-rich-rules
bantime  = 604800  # 7 Tage
findtime = 86400   # 1 Tag
maxretry = 5

[plesk-login]
enabled = true
filter = plesk-login
logpath = /var/log/plesk/panel.log
maxretry = 5

[plesk-apilogin]
enabled = true
filter = plesk-apilogin
logpath = /var/log/plesk/panel.log
maxretry = 5

[postfix]
enabled = true
filter = postfix
logpath = /var/log/maillog
maxretry = 5

[dovecot]
enabled = true
filter = dovecot
logpath = /var/log/maillog
maxretry = 5

[proftpd]
enabled = true
filter = proftpd
logpath = /var/log/secure
maxretry = 5

# Alternativ:
#[vsftpd] oder [pure-ftpd] mit jeweils angepasstem logpath und filter
```

---

## 🚀 Fail2Ban starten

```bash
systemctl restart fail2ban
```

### Status prüfen:

```bash
fail2ban-client status
fail2ban-client status sshd
```

---

## 🔥 Firewalld-Integration prüfen

Fail2Ban schreibt automatisch Firewalld-Regeln, wenn `banaction = firewallcmd-rich-rules` definiert ist. Du kannst dies prüfen mit:

```bash
firewall-cmd --permanent --zone=public --list-rich-rules
```

---

## 🧪 Troubleshooting

* Stelle sicher, dass Firewalld läuft: `systemctl status firewalld`
* Überprüfe Fail2Ban-Logs: `journalctl -u fail2ban` oder `tail -f /var/log/fail2ban.log`

---

## ✅ Ergebnis

* Plesk, SSH, FTP und Maildienste sind effektiv gegen Brute-Force-Angriffe geschützt
* Firewalld regelt IP-Sperren dynamisch und effizient
* Fail2Ban ist zukunftssicher ohne iptables

---

## 🧠 Tipp

Erweitere das Setup später mit eigenen benutzerdefinierten Filtern unter `/etc/fail2ban/filter.d/*.conf` und aktiviere diese wie oben gezeigt.

---

👨‍💻 *Dokumentiert von livednoiz & ChatGPT*
