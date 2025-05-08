#!/bin/bash
# fail2ban_setup.sh – Automatisiertes Setup für Fail2Ban mit Logging und Basic-Konfiguration

LOGFILE="~/logs/fail2ban_setup.log"

log() {
  echo "[$(date +"%Y-%m-%d %H:%M:%S")] $1" | tee -a "$LOGFILE"
}

log "===== Fail2Ban-Setup gestartet ====="

# Prüfen, ob Root-Rechte vorhanden sind
if [ "$EUID" -ne 0 ]; then
  log "Dieses Skript muss als root ausgeführt werden."
  exit 1
fi

# Update-Paketquellen und Installation
log "Aktualisiere Paketquellen..."
apt update -y >> "$LOGFILE" 2>&1

log "Installiere Fail2Ban..."
apt install -y fail2ban >> "$LOGFILE" 2>&1

# Basis-Konfiguration erstellen
F2B_JAIL_LOCAL="/etc/fail2ban/jail.local"

log "Erstelle Basis-Konfiguration: $F2B_JAIL_LOCAL"
cat > "$F2B_JAIL_LOCAL" <<EOF
[DEFAULT]
ban_time  = 1h
findtime  = 10m
maxretry  = 5
backend   = auto
destemail = root@localhost
sender    = fail2ban@localhost
action    = %(action_mwl)s

[sshd]
enabled = true
EOF

# Dienst aktivieren und starten
log "Aktiviere und starte Fail2Ban-Dienst..."
systemctl enable fail2ban >> "$LOGFILE" 2>&1
systemctl restart fail2ban >> "$LOGFILE" 2>&1

log "Fail2Ban-Status:"
systemctl status fail2ban --no-pager | tee -a "$LOGFILE"

log "Setup abgeschlossen. Log gespeichert in $LOGFILE"
log "===== Ende des Fail2Ban-Setups ====="
exit 0
# Hinweis: Dieses Skript ist für Debian-basierte Systeme (z.B. Ubuntu) konzipiert.
# Für andere Distributionen müssen die Paketmanager und Pfade entsprechend angepasst werden.
# Weitere Anpassungen können je nach spezifischen Anforderungen und Umgebung vorgenommen werden.
# Beispiel für die Anpassung der Konfiguration:
# - Anpassen der Ban-Zeiten und Retry-Werte
# - Hinzufügen weiterer Jails für andere Dienste (z.B. Apache, Nginx, etc.)
# - Anpassen der E-Mail-Benachrichtigungen
# - Anpassen der Logging-Optionen
# - Anpassen der Firewall-Regeln
# - Anpassen der IP-Whitelist/Blacklist
# - Anpassen der Fail2Ban-Filter
# - Anpassen der Fail2Ban-Aktionen
# - Anpassen der Fail2Ban-Überwachung
# - Anpassen der Fail2Ban-Statistiken
# - Anpassen der Fail2Ban-Backup-Strategien
# - Anpassen der Fail2Ban-Performance-Optimierungen
# - Anpassen der Fail2Ban-Fehlerbehebung
# - Anpassen der Fail2Ban-Tests
# - Anpassen der Fail2Ban-Dokumentation
# - Anpassen der Fail2Ban-Updates
# - Anpassen der Fail2Ban-Sicherheit
# - Anpassen der Fail2Ban-Compliance