#!/usr/bin/env bash
set -euo pipefail

: "${SMTP_SERVER:?Need SMTP_SERVER}"
: "${SMTP_PORT:=587}"
: "${SMTP_USER:?Need SMTP_USER}"
: "${SMTP_PASS:?Need SMTP_PASS}"
: "${MAIL_FROM:?Need MAIL_FROM}"
: "${MAIL_TO:?Need MAIL_TO}"
: "${MAIL_SUBJECT:=No subject}"


if [[ -n "${MAIL_BODY_FILE:-}" && -f "$MAIL_BODY FILE" ]]; then
  MAIL_BODY="$(<"$MAIL_BODY_FILE")"
else
  : "${MAIL_BODY:?Need MAIL_BODY or MAIL_BODY_FILE}"
fi


TMPMAIL=$(mktemp)
cat >"$TMPMAIL" <<EOF
From: ${MAIL_FROM}
To: ${MAIL_TO}
Subject: ${MAIL_SUBJECT}
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

${MAIL_BODY}
EOF


curl --url "smtp://${SMTP_SERVER}:${SMTP_PORT}" \
     --ssl-reqd \
     --mail-from "${MAIL_FROM}" \
     --mail-rcpt "${MAIL_TO}" \
     -upload-file "$TMPMAIL" \
     --user "${SMTP_USER}:${SMTP_PASS}" \
     --insecure


rm -f "$TMPMAIL"
echo "Echo sent to ${MAIL_TO}"
