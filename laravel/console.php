<?php
// routes/console.php (Laravel 11+). Ping URLs live in config/services.php:
//   'heartcron' => ['backup' => env('HEARTCRON_BACKUP_URL'), 'scheduler' => env('HEARTCRON_SCHEDULER_URL')],
// Guide: https://heartcron.com/guides/laravel-scheduler/

use Illuminate\Support\Facades\Schedule;

$backup = config('services.heartcron.backup');

Schedule::command('backup:run')
    ->dailyAt('03:17')
    ->withoutOverlapping()
    ->environments(['production'])
    ->pingBefore("$backup/start")
    ->pingOnSuccess($backup)
    ->pingOnFailure("$backup/fail");

// A heartbeat for the scheduler itself: if the `schedule:run` crontab line
// disappears, this stops pinging and Heartcron alerts within minutes.
Schedule::call(fn () => null)
    ->everyFiveMinutes()
    ->name('heartbeat')
    ->environments(['production'])
    ->thenPing(config('services.heartcron.scheduler'));
