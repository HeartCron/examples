# systemd timers

- `backup.service` pings on start and, only after a successful run, on success.
- `heartcron-fail@.service` sends `/fail` for any unit that fails, using the URL in `/etc/heartcron/<unit name>`.
- `backup.timer` runs the service every night.

```bash
echo 'PING_URL=https://ping.heartcron.com/<uuid>' | sudo tee /etc/heartcron/backup.service
sudo cp backup.service backup.timer heartcron-fail@.service /etc/systemd/system/
sudo systemctl daemon-reload && sudo systemctl enable --now backup.timer
```

Full guide: [Monitoring systemd timers](https://heartcron.com/guides/systemd-timers/).
