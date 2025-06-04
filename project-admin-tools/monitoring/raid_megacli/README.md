# 💾 RAID Monitoring mit MegaCli für Nagios / NRPE

## 🔍 Ziel

Dieses Projekt ermöglicht ein **detailliertes Monitoring eines Avago (LSI) MegaRAID-Controllers** via Nagios NRPE. Es erkennt:

* ✅ RAID-Zustand (Optimal / Degraded / Failed)
* ❌ Defekte, ausgefallene oder predictive failing Disks
* 🔄 Live-Statusabfrage über MegaCli

---

## 📦 Voraussetzungen

* AlmaLinux 9 / RHEL 9-kompatibles System
* Installiertes Paket: `MegaCli` (unter `/usr/sbin/MegaCli`)
* Nagios `nrpe`-Daemon
* Schreibrechte in `/usr/local/bin`

---

## 🛠️ Schritt 1: Skript bereitstellen

📄 **Datei:** `/usr/local/bin/check_megaraid_advanced.sh`

```bash
#!/bin/bash

MEGACLI="/usr/sbin/MegaCli"
if [ ! -x "$MEGACLI" ]; then
    echo "UNKNOWN: MegaCli not found at $MEGACLI"
    exit 3
fi

OUTPUT=$($MEGACLI -LDInfo -Lall -aALL 2>/dev/null)
VDSTATE=$(echo "$OUTPUT" | grep -i "State" | awk '{print $3}')

# Check for Physical Drive status
PD_OUTPUT=$($MEGACLI -PDList -aALL 2>/dev/null)

# Count offline, failed, and predictive failure disks
OFFLINE_COUNT=$(echo "$PD_OUTPUT" | grep -c "Firmware state: Offline")
FAILED_COUNT=$(echo "$PD_OUTPUT" | grep -c "Firmware state: Failed")
PREDFAIL_COUNT=$(echo "$PD_OUTPUT" | grep -c "Predictive Failure")

TOTAL_ISSUES=$((OFFLINE_COUNT + FAILED_COUNT + PREDFAIL_COUNT))

if [[ "$VDSTATE" != "Optimal" ]] || [[ "$TOTAL_ISSUES" -gt 0 ]]; then
    echo "CRITICAL: RAID status is $VDSTATE | Offline: $OFFLINE_COUNT, Failed: $FAILED_COUNT, Predictive Failures: $PREDFAIL_COUNT"
    exit 2
else
    echo "OK: RAID status is $VDSTATE | No issues detected"
    exit 0
fi
```

### ⚙️ Rechte setzen

```bash
sudo chmod +x /usr/local/bin/check_megaraid_advanced.sh
```

---

## 🧩 Schritt 2: NRPE konfigurieren

🔧 Öffne `/etc/nagios/nrpe.cfg` und ergänze:

```ini
command[check_megaraid]=/usr/local/bin/check_megaraid_advanced.sh
```

🔄 Danach NRPE neu starten:

```bash
sudo systemctl restart nrpe
```

---

## 🧪 Schritt 3: Tests

🔍 Direkt lokal:

```bash
/usr/local/bin/check_megaraid_advanced.sh
```

📡 Über NRPE:

```bash
/usr/lib64/nagios/plugins/check_nrpe -H 127.0.0.1 -c check_megaraid
```

---

## 🎁 Bonus: Performance-Daten (optional)

Für Monitoring-Tools wie **PNP4Nagios**, kann das Skript um diese Zeile erweitert werden:

```bash
echo "OK: RAID status is $VDSTATE | offline=$OFFLINE_COUNT failed=$FAILED_COUNT predictive=$PREDFAIL_COUNT"
```

Dadurch werden die Werte als Graphen darstellbar.

---

## 📮 Nächste Schritte (optional)

* [ ] Erweiterung: MailQueue-Monitoring für Plesk
* [ ] Einbindung in ein zentrales Monitoring-Template
* [ ] Automatisierte Alerts via E-Mail oder Telegram

---

## 🙌 Viel Erfolg und sicheres Monitoring!

Bei Fragen oder Erweiterungswünschen: einfach melden 🛡️
