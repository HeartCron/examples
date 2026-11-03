# Cron jobs in Docker

A separate scheduler container runs [supercronic](https://github.com/aptible/supercronic) with `crontab`. Each job pings Heartcron after it succeeds, so a stopped container, a missing crontab or a failing job all end in an alert.

Install supercronic in your image from its GitHub releases and check the published checksum.

Full guide: [Running and monitoring cron jobs in Docker](https://heartcron.com/guides/cron-in-docker/).
