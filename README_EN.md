# MagiskHluda

A Magisk / KernelSU / APatch module that starts [Florida](https://github.com/cergo666/Florida) (patched Frida-server) on boot.

Each Florida release ships a random listen port in `identities.json`. The module reads that port and binds **127.0.0.1** by default, not `0.0.0.0:27042`.

[Русский](README.md) · **English**

![GitHub repo size](https://img.shields.io/github/repo-size/cergo666/MagiskHluda)
![GitHub downloads](https://img.shields.io/github/downloads/cergo666/MagiskHluda/total)

## Install

1. Download a ZIP from [Releases](https://github.com/cergo666/MagiskHluda/releases) for your architecture, or the universal package.
2. Flash it with Magisk / KernelSU / KSUN / APatch.

Architectures: `arm64`, `arm`, `x86`, `x86_64`.

Module updates are checked on a CI schedule (~every 12 hours) when a new Florida release appears.

## Connect

The port is printed at install time and stored in `/data/adb/modules/magisk-hluda/module.cfg`:

```bash
adb forward tcp:<port> tcp:<port>
frida-ps -H 127.0.0.1:<port>
```

`frida -U` still talks to `tcp:27042` on the device. Either set listen/port in the Web UI to `0.0.0.0:27042`, or keep the stealth defaults and use `-H` as above.

See also [troubleshooting.md](troubleshooting.md).

## Web UI

The Magisk / KSU module page can open a small web UI:

- start / stop the server;
- status;
- listen address and port;
- extra CLI parameters.

Stopping Florida **may crash System UI**. Save work before stopping it.

## Build the package

The packager downloads `florida-server` and `identities.json` from [cergo666/Florida](https://github.com/cergo666/Florida).

```bash
./vcpkg install rapidjson restclient-cpp
cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=vcpkg/scripts/buildsystems/vcpkg.cmake
cmake --build build --config Release
./build/MagiskHluda
```

Module script checks:

```bash
sh tests/test_scripts.sh
```

## Limits

Florida removes well-known **strings** from the binary. It does not hide inline hooks or `.text` vs disk checks. If Florida is still detected, [ZygiskFrida](https://github.com/lico-n/ZygiskFrida) is an alternative.

## Links

- [Florida](https://github.com/cergo666/Florida)
- [Frida](https://github.com/frida/frida)
- [Ylarod/Florida](https://github.com/Ylarod/Florida)
- [StrongR-Frida](https://github.com/hzzheyang/strongR-frida-android)
- [magisk-frida](https://github.com/ViRb3/magisk-frida) ([issue #16](https://github.com/ViRb3/magisk-frida/issues/16))

<a href="https://github.com/cergo666/MagiskHluda/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cergo666/MagiskHluda" alt="contributors" />
</a>
