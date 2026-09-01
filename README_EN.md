# MagiskHluda

<p align="center">
  <a href="https://github.com/cergo666/MagiskHluda/releases"><img src="https://img.shields.io/github/v/release/cergo666/MagiskHluda?style=flat-square&logo=github" alt="release"></a>
  <a href="https://github.com/cergo666/MagiskHluda/releases"><img src="https://img.shields.io/github/downloads/cergo666/MagiskHluda/total?style=flat-square&color=blue" alt="downloads"></a>
  <a href="https://github.com/cergo666/MagiskHluda/releases/latest"><img src="https://img.shields.io/github/downloads/cergo666/MagiskHluda/latest/total?style=flat-square&label=latest%20downloads" alt="latest downloads"></a>
  <a href="https://github.com/cergo666/MagiskHluda/stargazers"><img src="https://img.shields.io/github/stars/cergo666/MagiskHluda?style=flat-square" alt="stars"></a>
  <a href="https://github.com/cergo666/MagiskHluda/actions/workflows/main.yml"><img src="https://img.shields.io/github/actions/workflow/status/cergo666/MagiskHluda/main.yml?style=flat-square&label=CI" alt="CI"></a>
  <img src="https://img.shields.io/github/repo-size/cergo666/MagiskHluda?style=flat-square" alt="repo size">
</p>

<p align="center">
  <a href="README.md">Русский</a> · <b>English</b>
  &nbsp;·&nbsp;
  <a href="https://github.com/cergo666/Florida"><img src="https://img.shields.io/github/v/release/cergo666/Florida?style=flat-square&label=Florida" alt="Florida"></a>
</p>

A Magisk / KernelSU / APatch module that starts [Florida](https://github.com/cergo666/Florida) (patched Frida-server) on boot.

Each Florida release ships a random listen port in `identities.json`. The module reads that port and binds **127.0.0.1** by default, not `0.0.0.0:27042`.

## Ecosystem

| Repo | Role |
|---|---|
| [Florida](https://github.com/cergo666/Florida) | builds `florida-server` / gadget / inject |
| **MagiskHluda** (this one) | Magisk / KernelSU / APatch module, start on boot |
| [Ylarod/Florida](https://github.com/Ylarod/Florida) | original fork |

## Install

1. Download a ZIP from [Releases](https://github.com/cergo666/MagiskHluda/releases) for your architecture, or the universal package.
2. Flash it with Magisk / KernelSU / KSUN / APatch.

Architectures: `arm64`, `arm`, `x86`, `x86_64`.

Module updates are checked on a CI schedule (~every 12 hours) when a new Florida release appears.

## Connect

The port is in `/data/adb/modules/magisk-hluda/module.cfg`. Easiest path: host wrapper `scripts/hluda` — it reads the port, runs `adb forward`, and injects `-H`.

```bash
chmod +x scripts/hluda
ln -sf "$PWD/scripts/hluda" ~/.local/bin/hluda
ln -sf "$PWD/scripts/hluda" ~/.local/bin/hluda-ps

hluda ps                          # instead of frida-ps -H 127.0.0.1:<port>
hluda -f com.example.app          # instead of frida -U -f ...
hluda -f com.example.app -l hook.js
```

Multiple devices: `ANDROID_SERIAL=emulator-5554 hluda ps`.

By hand:

```bash
adb forward tcp:<port> tcp:<port>
frida-ps -H 127.0.0.1:<port>
```

`frida -U` still talks to `tcp:27042` on the device. Either set `listen=127.0.0.1` and `port=27042` in the Web UI, or keep the stealth defaults and use `hluda`.

See also [troubleshooting.md](troubleshooting.md).

## Web UI

The Magisk / KSU module page can open a small web UI:

- start / stop the server;
- status;
- listen address and port;
- extra CLI parameters.

Stopping Florida **may crash System UI**. Save work before stopping it.

## Build

The packager downloads `florida-server` and `identities.json` from [cergo666/Florida](https://github.com/cergo666/Florida).

```bash
./vcpkg install rapidjson restclient-cpp
cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=vcpkg/scripts/buildsystems/vcpkg.cmake
cmake --build build --config Release
./build/MagiskHluda
```

## Tests

```bash
sh tests/test_scripts.sh
```

CI runs these checks on every push.

## Limits

Florida removes well-known **strings** from the binary. It does not hide inline hooks or `.text` vs disk checks. If Florida is still detected, [ZygiskFrida](https://github.com/lico-n/ZygiskFrida) is an alternative.

## Links

- [Florida](https://github.com/cergo666/Florida)
- [Frida](https://github.com/frida/frida)
- [Ylarod/Florida](https://github.com/Ylarod/Florida)
- [StrongR-Frida](https://github.com/hzzheyang/strongR-frida-android)
- [magisk-frida](https://github.com/ViRb3/magisk-frida) ([issue #16](https://github.com/ViRb3/magisk-frida/issues/16))

<p align="center">
  <a href="https://github.com/cergo666/MagiskHluda/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=cergo666/MagiskHluda" alt="contributors">
  </a>
</p>
