#!/usr/bin/env bash
# Nightly PostgreSQL backup that reports to Heartcron: start, failures with the
# line that failed, a suspiciously small dump, and success with the dump size.
# Guide: https://heartcron.com/guides/monitor-backups/
set -euo pipefail

PING=${HEARTCRON_URL:?set HEARTCRON_URL to the ping URL of the check}
FILE=/var/backups/app-$(date +%F).sql.gz
MIN_BYTES=${MIN_BYTES:-1000000}

curl -fsS -m 10 --retry 3 -o /dev/null "$PING/start" || true
trap 'curl -fsS -m 10 --retry 3 -o /dev/null --data-raw "failed at line $LINENO" "$PING/fail"' ERR

pg_dump "$DATABASE_URL" | gzip > "$FILE"

SIZE=$(stat -c %s "$FILE" 2>/dev/null || stat -f %z "$FILE")
if [ "$SIZE" -lt "$MIN_BYTES" ]; then
  echo "dump is only $SIZE bytes" >&2
  false
fi

# upload somewhere off the server, for example:
# aws s3 cp "$FILE" "s3://my-backups/$(basename "$FILE")"

curl -fsS -m 10 --retry 3 -o /dev/null --data-raw "size=$SIZE" "$PING"
