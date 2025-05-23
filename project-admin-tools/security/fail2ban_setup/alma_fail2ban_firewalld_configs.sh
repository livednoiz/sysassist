#!/bin/bash

# -------------------------------------------
# 🔐 Firewalld & Fail2Ban Setup for Plesk on AlmaLinux 9
# -------------------------------------------
# Author: DevOps @ Obscuras Media
# Purpose: Secure Plesk environment using firewalld & fail2ban
# Tested: AlmaLinux 9 + Plesk Obsidian
# -------------------------------------------

echo "🚀 Starting secure Plesk server hardening..."

# 🧱 Firewalld Configuration (Essential Plesk + Mail + DB + FTP + SSH Ports)
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent
firewall-cmd --zone=public --add-service=ssh --permanent        # SSH added
firewall-cmd --zone=public --add-port=8443/tcp --permanent      # Plesk Admin Panel
firewall-cmd --zone=public --add-port=8447/tcp --permanent      # Plesk Installer
firewall-cmd --zone=public --add-port=20-21/tcp --permanent     # FTP
firewall-cmd --zone=public --add-port=49152-65535/tcp --permanent # Passive FTP
firewall-cmd --zone=public --add-port=25/tcp --permanent        # SMTP
firewall-cmd --zone=public --add-port=465/tcp --permanent       # SMTPS
firewall-cmd --zone=public --add-port=587/tcp --permanent       # Submission
firewall-cmd --zone=public --add-port=110/tcp --permanent       # POP3
firewall-cmd --zone=public --add-port=995/tcp --permanent       # POP3S
firewall-cmd --zone=public --add-port=143/tcp --permanent       # IMAP
firewall-cmd --zone=public --add-port=993/tcp --permanent       # IMAPS
firewall-cmd --zone=public --add-port=3306/tcp --permanent      # MySQL
firewall-cmd --zone=public --add-port=5432/tcp --permanent      # PostgreSQL

# ✅ Reload firewalld
firewall-cmd --reload
echo "✅ firewalld ports configured."

# 🛡️ Fail2Ban jail.local configuration
cat <<EOL > /etc/fail2ban/jail.local
[DEFAULT]
bantime  = 86400
findtime = 5400
maxretry = 5
backend  = systemd

[sshd]
enabled  = true
filter   = sshd
action   = firewallcmd-rich-rules[name=SSH, port=ssh, protocol=tcp]
logpath  = /var/log/secure

[plesk-login]
enabled  = true
filter   = plesk-login
action   = firewallcmd-rich-rules[name=PleskLogin, port=8443, protocol=tcp]
logpath  = /var/log/plesk/panel.log

[plesk-apilogin]
enabled  = true
filter   = plesk-apilogin
action   = firewallcmd-rich-rules[name=PleskAPI, port=8443, protocol=tcp]
logpath  = /var/log/plesk/panel.log

[postfix]
enabled  = true
filter   = postfix
action   = firewallcmd-rich-rules[name=Postfix, port=smtp, protocol=tcp]
logpath  = /var/log/maillog

[dovecot]
enabled  = true
filter   = dovecot
action   = firewallcmd-rich-rules[name=Dovecot, port=pop3, protocol=tcp]
logpath  = /var/log/maillog

[proftpd]
enabled  = true
filter   = proftpd
action   = firewallcmd-rich-rules[name=ProFTPD, port=21, protocol=tcp]
logpath  = /var/log/secure

[recidive]
enabled  = true
filter   = recidive
logpath  = /var/log/fail2ban.log
action   = firewallcmd-rich-rules[name=Recidive, port=all, protocol=all]
bantime  = 604800
findtime = 86400
maxretry = 5
EOL

# 🔄 Restart Fail2Ban
systemctl restart fail2ban
systemctl enable fail2ban

# ✅ Output status
systemctl --no-pager -l status fail2ban.service

echo "🛡️ Fail2Ban is now actively protecting your Plesk environment."
echo "👨‍💻 Use 'fail2ban-client status <jail>' to inspect jail activity."
