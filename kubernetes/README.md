# Kubernetes CronJob

`cronjob.yaml` pings Heartcron when the job starts and reports its exit code at the end. `activeDeadlineSeconds` stops a hung run, and `startingDeadlineSeconds` keeps missed starts from piling up into the “too many missed start times” state, where the controller stops scheduling the job.

Full guide: [Monitoring Kubernetes CronJobs](https://heartcron.com/guides/kubernetes-cronjob/).
