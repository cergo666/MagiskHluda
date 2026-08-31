# Troubleshooting

## Listen address / port
- Default is `127.0.0.1` and the port from Florida's `identities.json` (not 27042)
- Check `/data/adb/modules/magisk-hluda/module.cfg` for `listen=` and `port=`
- Forward that port: `adb forward tcp:<port> tcp:<port>` then `frida-ps -H 127.0.0.1:<port>`
- If you need `frida -U`, set listen to `0.0.0.0` and port `27042` in the Web UI

## Try first
- Ensure `adb devices` shows your device
- Ensure `adb shell` opens a working shell on your device
- Try running `florida` [through an ADB shell](https://www.frida.re/docs/android/)
- Ensure Magisk is at a STABLE version and up-to-date
- Ensure MagiskHide is disabled
- Ensure you are on an AOSP-based ROM

## Not solved?
IDK I'm just a student :| , search for "frida-server + your error" or try opening an issue with some info about your device and any logs would be helpful, and I'll help if I can 😃.