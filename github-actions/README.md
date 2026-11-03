# Scheduled GitHub Actions

`nightly.yml` uses [heartcron/ping-action](https://github.com/HeartCron/ping-action) to report the start and the result of a scheduled workflow, with the log attached. Heartcron alerts you when the run fails, hangs, or doesn’t happen at all, for example when GitHub disables the schedule on a quiet repository.

Full guide: [Monitoring scheduled GitHub Actions workflows](https://heartcron.com/guides/github-actions-schedule/).
