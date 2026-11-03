# Wrap any command

`heartcron-run.sh` reports a start, then the exit code and the last 10 KB of output, and passes the exit code through.

```bash
HEARTCRON_URL=https://ping.heartcron.com/<uuid> ./heartcron-run.sh /opt/backup.sh
```

In a crontab:

```
17 3 * * * HEARTCRON_URL=https://ping.heartcron.com/<uuid> /usr/local/bin/heartcron-run.sh /opt/backup.sh
```

A non-zero exit code sends an alert right away; a run that never finishes is reported after the check’s grace period.
