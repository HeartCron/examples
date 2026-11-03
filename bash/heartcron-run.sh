#!/usr/bin/env bash
# heartcron-run.sh — run any command and report it to Heartcron:
# a start ping, then the exit code with the last 10 KB of output.
#
#   HEARTCRON_URL=https://ping.heartcron.com/<uuid> ./heartcron-run.sh ./backup.sh --full
#
# The command's exit code is passed through, so cron and CI still see failures.
set -uo pipefail

if [ -z "${HEARTCRON_URL:-}" ] || [ $# -eq 0 ]; then
  echo "usage: HEARTCRON_URL=<ping url> $0 command [args...]" >&2
  exit 2
fi

ping() { curl -fsS -m 10 --retry 3 -o /dev/null "$@" || echo "heartcron: ping failed" >&2; }

ping "$HEARTCRON_URL/start"
out=$(mktemp)
trap 'rm -f "$out"' EXIT
"$@" > >(tee -a "$out") 2> >(tee -a "$out" >&2)
code=$?
wait
tail -c 10000 "$out" | ping --data-binary @- "$HEARTCRON_URL/$code"
exit "$code"
