#!/bin/bash
# System Upgrade Script für Debian-basierte Distributionen (Debian, Ubuntu)
# Version: 0.2.1
# Autor: [Sascha Gebel]
# Beschreibung: Dieses Skript führt ein automatisches Systemupgrade durch und protokolliert den Fortschritt in einer Logdatei.
# Es wird empfohlen, dieses Skript in einer sicheren Umgebung zu testen, bevor es in der Produktion eingesetzt wird.
# Hinweis: Dieses Skript ist für Debian-basierte Distributionen wie Ubuntu und Debian gedacht.
# Es wird empfohlen, dieses Skript in einer sicheren Umgebung zu testen, bevor es in der Produktion eingesetzt wird.
# Stellen Sie sicher, dass Sie eine Sicherung wichtiger Daten haben, bevor Sie das Upgrade durchführen.
# Dieses Skript wird ohne Gewährleistung bereitgestellt. Verwenden Sie es auf eigenes Risiko.

# Titel im Terminal setzen
echo -ne "\033]0;Extended System Upgrade Beta v0.2.1\007"

# Farbdefinitionen
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

# Logdatei definieren (standard: im Homeverzeichnis)
LOGFILE="$HOME/sysupgrade.log"

# Sicherstellen, dass die Logdatei geschrieben werden kann
if ! touch "$LOGFILE" &>/dev/null; then
  echo -e "${RED}WARNUNG:${NOCOLOR} Logdatei konnte nicht erstellt werden: $LOGFILE"
  LOGFILE="/tmp/sysupgrade.log"
  echo -e "${GREEN}Falle zurück auf temporäre Logdatei:${NOCOLOR} $LOGFILE"
fi

log() {
  local STEP="$1"
  local MSG="$2"
  echo -e "step $STEP: ${GREEN}$MSG${NOCOLOR}"
  echo "[step $STEP] $MSG" | tee -a "$LOGFILE"
  logger "step $STEP: $MSG"
}

fail() {
  local STEP="$1"
  local MSG="$2"
  echo -e "step $STEP ERROR: ${RED}$MSG${NOCOLOR}"
  echo "[step $STEP ERROR] $MSG" | tee -a "$LOGFILE"
  logger "step $STEP ERROR: $MSG"
}

# Hilfe anzeigen
if [[ $1 == "-h" ]]; then
  echo "Usage: $0 [-h]"
  echo "Automatisches Systemupgrade mit Logging."
  exit 0
fi

# Schritte starten
log 1 "pre-configuring debian packages"
sudo dpkg --configure -a

log 2 "fix broken dependencies"
sudo apt-get install -f

log 3 "update apt cache"
sudo apt-get update

log 4 "upgrade packages"
sudo apt-get upgrade -y

log 5 "distribution upgrade"
sudo apt-get dist-upgrade -y

log 6 "refresh snap packages"
sudo snap refresh

log 7 "remove unused packages"
sudo apt-get --purge autoremove -y

log 8 "clean up apt cache"
sudo apt-get autoclean

log 9 "optional steps"
echo foo
log 10 "another step"
echo bar
log 11 "final test step"
echo baz
if [[ $1 == 0 ]]; then
  fail 11 "no action triggered"
fi

log 12 "process complete"
echo -e "${GREEN}Systemaktualisierung abgeschlossen.${NOCOLOR}"

read -n 1 -p "Neustart oder Herunterfahren? (E/r/s) " ans;
echo

case $ans in
  r|R)
    sudo reboot;;
  s|S)
    sudo poweroff;;
  *)
    exit;;
esac
# Ende des Skripts
# Hinweis: Dieses Skript ist für Debian-basierte Distributionen wie Ubuntu und Debian gedacht.
# Es wird empfohlen, dieses Skript in einer sicheren Umgebung zu testen, bevor es in der Produktion eingesetzt wird.
# Stellen Sie sicher, dass Sie eine Sicherung wichtiger Daten haben, bevor Sie das Upgrade durchführen.
# Dieses Skript wird ohne Gewährleistung bereitgestellt. Verwenden Sie es auf eigenes Risiko.
# Weitere Informationen zu apt und seinen Optionen finden Sie in der offiziellen Dokumentation:
# https://manpages.debian.org/bullseye/apt/apt.8.en.html
# Weitere Informationen zu System-Upgrades und Best Practices finden Sie in der offiziellen Dokumentation:
# https://help.ubuntu.com/community/UpgradeNotes
# Weitere Informationen zu Debian und Ubuntu finden Sie in der offiziellen Dokumentation:
# https://www.debian.org/doc/
# https://help.ubuntu.com/community/Documentation
# Weitere Informationen zur Systemadministration und Best Practices finden Sie in der offiziellen Dokumentation:
# https://help.ubuntu.com/community/SystemAdministration
# Weitere Informationen zur Systemsicherheit und Best Practices finden Sie in der offiziellen Dokumentation:
# https://help.ubuntu.com/community/Security
# Weitere Informationen zur Systemleistungsoptimierung und Best Practices finden Sie in der offiziellen Dokumentation:
# https://help.ubuntu.com/community/PerformanceTuning
# Weitere Informationen zur Systemüberwachung und Best Practices finden Sie in der offiziellen Dokumentation:
# https://help.ubuntu.com/community/Monitoring
# Weitere Informationen zur Systemfehlerbehebung und Best Practices finden Sie in der offiziellen Dokumentation:
# https://help.ubuntu.com/community/Troubleshooting
# Weitere Informationen zur Systemsicherung und -wiederherstellung und Best Practices finden Sie in der offiziellen Dokumentation:
# https://help.ubuntu.com/community/BackupYourSystem
# Weitere Informationen zu Systemaktualisierungen und Best Practices finden Sie in der offiziellen Dokumentation:
# https://help.ubuntu.com/community/UpgradeNotes