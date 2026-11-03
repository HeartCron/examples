# PostgreSQL backup

`backup.sh` dumps the database and tells Heartcron how it went: a start ping, an immediate failure with the line number if any command fails (including inside the pipe), a failure when the dump is smaller than `MIN_BYTES`, and a success ping with the dump size.

```
17 3 * * * HEARTCRON_URL=https://ping.heartcron.com/<uuid> DATABASE_URL=postgres://... /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1
```

In Heartcron, give the check the schedule `17 3 * * *` and a grace period longer than a normal run.

Full guide: [How to monitor database backups](https://heartcron.com/guides/monitor-backups/).
