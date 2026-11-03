# Heartcron examples

Copy-paste examples for monitoring scheduled jobs with [Heartcron](https://heartcron.com): each job pings Heartcron when it starts and finishes, and you get an alert in Telegram, Slack, Discord or email when it fails, hangs or doesn’t run at all.

| Folder | What’s inside | Guide |
|---|---|---|
| [`bash`](bash) | Wrap any command: start, exit code and output | [Docs](https://heartcron.com/docs/) |
| [`backup-postgres`](backup-postgres) | A backup script that reports failures and empty dumps | [Monitoring backups](https://heartcron.com/guides/monitor-backups/) |
| [`docker`](docker) | A scheduler container with supercronic | [Cron in Docker](https://heartcron.com/guides/cron-in-docker/) |
| [`kubernetes`](kubernetes) | A CronJob that reports its exit code | [Kubernetes CronJobs](https://heartcron.com/guides/kubernetes-cronjob/) |
| [`systemd`](systemd) | A timer with a success ping and an OnFailure hook | [systemd timers](https://heartcron.com/guides/systemd-timers/) |
| [`github-actions`](github-actions) | A scheduled workflow with heartcron/ping-action | [GitHub Actions](https://heartcron.com/guides/github-actions-schedule/) |
| [`laravel`](laravel) | Scheduler pings and a heartbeat for the scheduler | [Laravel scheduler](https://heartcron.com/guides/laravel-scheduler/) |
| [`python`](python) | A dependency-free context manager | |
| [`node`](node) | A dependency-free wrapper for async jobs | |

## The idea in one line

```
0 3 * * * /opt/backup.sh && curl -fsS -m 10 --retry 3 https://ping.heartcron.com/<uuid>
```

If the ping doesn’t arrive on schedule, the job didn’t run or failed. Add `/start` at the beginning to catch hung runs, and `/fail` or the exit code (`/$?`) to get the alert right away. Not sure what a cron expression means? Paste it into the [cron expression explainer](https://heartcron.com/cron/).

The Free plan covers 20 cron jobs and 10 websites, no card needed.

## License

MIT
