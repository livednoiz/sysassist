#!/bin/bash

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

