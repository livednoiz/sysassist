#!/bin/bash

# ===============================================
# 🛡️  Plesk Full Backup Automation Script
# ===============================================

# Load .env if present
if [ -f ".env" ]; then
    set -a
    source .env
    set +a
fi

# === Default Settings ===
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BACKUP_DIR=${BACKUP_DIR:-"/root/plesk_backups/$TIMESTAMP"}
BACKUP_NAME=${BACKUP_NAME:-"plesk-backup-$TIMESTAMP"}
BACKUP_USER=${BACKUP_USER:-"admin"}
BACKUP_STORAGE=${BACKUP_STORAGE:-"local"}
EMAIL_NOTIFICATION=${EMAIL_NOTIFICATION:-"no"}
EMAIL_ADDRESS=${EMAIL_ADDRESS:-"admin@example.com"}

# Create backup directory
mkdir -p "$BACKUP_DIR"
chmod 700 "$BACKUP_DIR"

echo "📦 Starting full backup into $BACKUP_DIR ..."

# Run Plesk backup command
plesk bin pleskbackup server \
    -output-file="$BACKUP_DIR/$BACKUP_NAME.tar" \
    -backup-content=all \
    -nosplit

# Check backup result
if [ $? -ne 0 ]; then
    echo "❌ Backup failed!"
    exit 1
else
    echo "✅ Backup successful: $BACKUP_DIR/$BACKUP_NAME.tar"
fi

# Optional: Export all MySQL/MariaDB databases individually
echo "📤 Dumping all MariaDB databases..."
mkdir -p "$BACKUP_DIR/db_dumps"
databases=$(mysql -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql|sys)")

for db in $databases; do
    echo "Dumping $db ..."
    mysqldump --single-transaction "$db" > "$BACKUP_DIR/db_dumps/${db}.sql"
done

# Optional: Backup custom directories (e.g. /var/www/vhosts)
echo "🗂️ Backing up vhosts..."
tar czf "$BACKUP_DIR/vhosts.tar.gz" /var/www/vhosts/

# Optional: Notify via email (requires mailx)
if [[ "$EMAIL_NOTIFICATION" == "yes" ]]; then
    echo "✅ Plesk backup completed at $TIMESTAMP" | mailx -s "Plesk Backup Report" "$EMAIL_ADDRESS"
fi

echo "🎉 Backup finished. Files saved in: $BACKUP_DIR"
