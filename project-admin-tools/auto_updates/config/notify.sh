#!/bin/bash

REBOOT=$1

# Beispiel: einfache E-Mail-Benachrichtigung (mutt/sendmail vorausgesetzt)
SUBJECT="[Update-Report] $(hostname) - $(date '+%F %T')"
MESSAGE="System wurde erfolgreich aktualisiert.\n"

if [ "$REBOOT" = true ]; then
    MESSAGE+="Ein Neustart ist erforderlich.\n"
fi

echo -e "$MESSAGE" | mail -s "$SUBJECT" dein-admin@example.com
# Beispiel: Slack-Benachrichtigung (curl vorausgesetzt)
# curl -X POST -H 'Content-type: application/json' --data '{"text":"'"$MESSAGE"'"}' https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX
# Beispiel: Discord-Benachrichtigung (curl vorausgesetzt)
# curl -X POST -H 'Content-type: application/json' --data '{"content":"'"$MESSAGE"'"}' https://discord.com/api/webhooks/YOUR_WEBHOOK_URL
# Beispiel: Telegram-Benachrichtigung (curl vorausgesetzt)
# curl -X POST -H 'Content-type: application/json' --data '{"text":"'"$MESSAGE"'"}' https://api.telegram.org/b