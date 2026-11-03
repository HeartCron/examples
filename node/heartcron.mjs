// Report a Node.js job to Heartcron with no dependencies (Node 18+).
//
//   import { monitor } from "./heartcron.mjs";
//   await monitor(process.env.HEARTCRON_URL, async () => { await runReport(); });
//
// Pings /start, then success, or /fail with the error. A ping that can't be
// delivered never breaks the job.

export async function ping(url, body) {
  try {
    await fetch(url, {
      method: body ? "POST" : "GET",
      body: body ? String(body).slice(-10000) : undefined,
      headers: { "User-Agent": "heartcron-node" },
      signal: AbortSignal.timeout(10_000),
    });
  } catch (err) {
    console.error(`heartcron: ping failed: ${err.message}`);
  }
}

export async function monitor(url, job) {
  const base = url.replace(/\/+$/, "");
  await ping(`${base}/start`);
  try {
    const result = await job();
    await ping(base);
    return result;
  } catch (err) {
    await ping(`${base}/fail`, err && err.stack ? err.stack : String(err));
    throw err;
  }
}
