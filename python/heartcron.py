"""Report a Python job to Heartcron with no dependencies.

    from heartcron import monitor

    with monitor("https://ping.heartcron.com/<uuid>"):
        run_report()

Pings /start, then success, or /fail with the error when an exception escapes.
A ping that can't be delivered never breaks the job.
"""
import contextlib
import traceback
import urllib.request


def ping(url, body=None, timeout=10):
    data = body.encode()[-10000:] if body else None
    try:
        urllib.request.urlopen(urllib.request.Request(url, data=data, headers={"User-Agent": "heartcron-python"}), timeout=timeout)
    except Exception as exc:  # monitoring must not break the job
        print(f"heartcron: ping failed: {exc}")


@contextlib.contextmanager
def monitor(url):
    url = url.rstrip("/")
    ping(url + "/start")
    try:
        yield
    except BaseException:
        ping(url + "/fail", traceback.format_exc())
        raise
    ping(url)


if __name__ == "__main__":
    import os, sys, time
    with monitor(os.environ["HEARTCRON_URL"]):
        print("working...")
        time.sleep(1)
    sys.exit(0)
