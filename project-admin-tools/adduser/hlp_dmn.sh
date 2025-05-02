#!/bin/bash

# Dieses Skript erstellt einen neuen Benutzer mit dem Namen "developer" und fügt ihn zur Gruppe "wheel" hinzu, um ihm sudo-Rechte zu gewähren. 
# Es erstellt auch ein .ssh-Verzeichnis für den Benutzer und fügt einen öffentlichen SSH-Schlüssel hinzu.
# Das Skript überprüft, ob es mit sudo-Rechten ausgeführt wird, und gibt eine Fehlermeldung aus, wenn dies nicht der Fall ist.
# Das Skript konfiguriert auch den SSH-Server, um die Verwendung von öffentlichen Schlüsseln zu ermöglichen.
# Hinweis: Dieses Skript sollte mit Bedacht verwendet werden, da es sicherheitsrelevante Änderungen am System vornimmt.
# Dynamisches Setup mit Werten aus einer .env-Datei

# Lade Konfiguration aus .env-Datei
#if [ -f .env ]; then
#    export $(grep -v '^#' .env | xargs)
#else
#    echo "Fehler: .env-Datei nicht gefunden!"
#    exit 1
#fi

# Lade .env ohne Quotes
set -a
source .env
set +a

echo "Benutzer: $SUSER"
echo "SSH Key:"
echo "$SSH_KEY"

# Checke Bash und Root-Rechte
if [ -z "$BASH_VERSION" ]; then
    echo "Dieses Skript muss mit Bash ausgeführt werden."
    exit 1
fi

if [ "$(id -u)" -ne 0 ]; then
    echo "Dieses Skript muss mit root-Rechten ausgeführt werden."
    exit 1
fi

# Nutzeranlage
echo "Erstelle Benutzer: $USERNAME"
useradd -m "$USERNAME"
passwd "$USERNAME"

# Sudo-Rechte
echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
usermod -aG wheel "$USERNAME"

# SSH-Verzeichnis & Key
mkdir -p /home/$USERNAME/.ssh
echo "$SSH_KEY" > /home/$USERNAME/.ssh/authorized_keys
chmod 700 /home/$USERNAME/.ssh
chmod 600 /home/$USERNAME/.ssh/authorized_keys
chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

# SSHD-Config Update
if ! grep -q "PubkeyAuthentication yes" /etc/ssh/sshd_config; then
    echo -e "\nPubkeyAuthentication yes\nAuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config
    systemctl restart sshd
fi

echo "Überprüfe die SSH-Konfiguration"
if ! grep -q "PubkeyAuthentication yes" /etc/ssh/sshd_config; then
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
    echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config
    systemctl restart sshd
fi

echo "Benutzer $USERNAME eingerichtet und konfiguriert."
echo "SSH-Zugriff mit Public Key konfiguriert."
echo "SSH-Dienst neu gestartet."
echo "Fertig!"

# Hinweis: Dieses Skript muss mit "chmod +x setup_user.sh" ausführbar gemacht werden, bevor es ausgeführt werden kann.
# Beispiel für die Ausführung des Skripts:
# sudo ./setup_user.sh
# Autor: [Sascha Gebel]
# Datum: [2025-04-17]