# Laravel scheduler

`console.php` pings Heartcron from a scheduled task (start, success, failure) and adds a heartbeat for the scheduler itself, so a missing `schedule:run` crontab line is noticed in minutes rather than weeks. The ping methods use Guzzle, which new Laravel apps include.

Full guide: [Monitoring the Laravel task scheduler](https://heartcron.com/guides/laravel-scheduler/).
