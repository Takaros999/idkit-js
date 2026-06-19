# Partner standalone flow

Hacky static example for reproducing a partner-style `idkit-standalone` integration.

It mirrors the important browser-side pieces of the observed flow:

-   dynamically inject `https://unpkg.com/@worldcoin/idkit-standalone@2.0.2/build/index.global.js` as `script-world-id`
-   initialize `window.IDKit` with the selected `app_id` / `action`, `verification_level: "device"`, `partner: true`, `show_modal: true`, and `disable_default_modal_behavior: true`
-   show the exact IDKit config used by the example
-   toggle between the IDKit Example app and Partner app (Razer)
-   display the raw JSON received by `handleVerify`, `onSuccess`, or `onError`

Run it with any static file server:

```sh
cd examples/with-partner-standalone
python3 -m http.server 5174 --bind 127.0.0.1
```

Then open `http://127.0.0.1:5174/`.
