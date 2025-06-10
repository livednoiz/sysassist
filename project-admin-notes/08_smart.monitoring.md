# ✅ SMART-Monitoring mit Mailbenachrichtigung (ohne Nagios)

Diese Anleitung zeigt, wie du eine einfache und effektive ∅Lösung zur Überwachung von SMART-Daten auf einem Linux-Server umsetzt.
Sie eignet sich hervorragend als Ersatz für Nagios-basierte Lösungen bei Hardware- oder Software-RAID-Systemen.

---

## 🔧 1. Installation der benötigten Tools

```bash
dnf install smartmontools -y
```

Alternativ (Debian/Ubuntu):

```bash
apt install smartmontools -y
```

---

## ⚙️ 2. Dienst aktivieren

```bash
systemctl enable --now smartd
```

---

## 📝 3. Konfiguration in `/etc/smartd.conf`

```conf
DEVICESCAN -a -o on -S on -s (S/../.././02|L/../../7/03) -W 4,45,50 -m root -M exec /usr/local/bin/smart_mail_notify.sh
```

### Parameter-Erklärung:

* `-a`: Alle verfügbaren SMART-Werte auslesen
* `-o on`: Offline-Datensammlung aktivieren
* `-S on`: Attribute zwischen Reboots speichern
* `-s`: Zeitplan für Short- (02 Uhr) und Long-Tests (So 03 Uhr)
* `-W`: Temperaturgrenzen (info=45, warn=50)
* `-m`: Mail-Empfänger (z. B. root oder externe Mail)
* `-M exec`: eigenes Benachrichtigungsskript bei Problemen

---

## 📬 4. Benachrichtigungsskript `/usr/local/bin/smart_mail_notify.sh`

```bash
#!/bin/bash
EMAIL="deine@email.de"
HOST=$(hostname)
MSG=$(cat)

echo -e "To: $EMAIL\nSubject: [SMART-ALARM] auf $HOST\n\n$MSG" | /usr/sbin/sendmail -t
```

Speichern, dann:

```bash
chmod +x /usr/local/bin/smart_mail_notify.sh
```

---

## 🧪 5. Testen

Manueller Test der Festplatte:

```bash
smartctl -a /dev/sda
```

SMART-Dienst neustarten:

```bash
systemctl restart smartd
```

---

## 🧰 Zusatz für RAID: MegaRAID-Controller (Avago, PERC, etc.)

Wenn `smartctl` nicht direkt zugreifen kann:

```bash
/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aALL | grep -E 'Firmware state|Media Error|Predictive Failure'
```

Diese Ausgabe kann ebenfalls per Shellscript überwacht und ausgewertet werden (analog zum SMART-Beispiel).

---

## 🛠 Mail-Versand einrichten

Je nach Distribution:

* **sendmail**:

```bash
dnf install sendmail -y
systemctl enable --now sendmail
```

* **alternativ**: `ssmtp`, `mailx`, `msmtp` oder exim

---

## ✅ Vorteile dieser Lösung

* Kein Nagios notwendig
* Volle Kontrolle über Inhalt & Schwellenwerte
* RAID-kompatibel (mit Megacli/storcli)
* Erweiterbar auf weitere Dienste (z. B. MailQueue, RAM, Temp)
* Kann CRON oder systemd Timer nutzen

---

## 💡 Bonus: CRON zur wöchentlichen RAID-Prüfung

```cron
0 4 * * 1 /opt/MegaRAID/MegaCli/MegaCli64 -PDList -aALL | grep -E 'Error|Failure' | mail -s "[RAID-Warnung]" deine@email.de
```

---

> 🚨 **Tipp:** Wenn du mehrere Platten hast, kann man `smartctl -a /dev/sdX` für jede Device individuell angeben und auswerten.

Fertig! Dein System ist nun gegen SMART-Ausfälle gewappnet ✅
