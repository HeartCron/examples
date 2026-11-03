# Python

`heartcron.py` is a small, dependency-free context manager: it pings `/start`, then success, or `/fail` with the traceback if an exception escapes. Copy it next to your job.

```python
from heartcron import monitor

with monitor(os.environ["HEARTCRON_URL"]):
    run_report()
```
