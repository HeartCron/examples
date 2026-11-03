# Node.js

`heartcron.mjs` wraps a job: it pings `/start`, then success, or `/fail` with the error stack. It uses the built-in `fetch`, so it needs Node 18 or newer and nothing else.

```js
import { monitor } from "./heartcron.mjs";

await monitor(process.env.HEARTCRON_URL, async () => {
  await runReport();
});
```
