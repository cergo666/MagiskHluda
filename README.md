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
  <b>Русский</b> · <a href="README_EN.md">English</a>
  &nbsp;·&nbsp;
  <a href="https://github.com/cergo666/Florida"><img src="https://img.shields.io/github/v/release/cergo666/Florida?style=flat-square&label=Florida" alt="Florida"></a>
</p>

Magisk / KernelSU / APatch-модуль: [Florida](https://github.com/cergo666/Florida) (патченый Frida-server) поднимается при загрузке системы.

Каждый релиз Florida кладёт случайный порт в `identities.json`. Модуль читает его и по умолчанию слушает **127.0.0.1**, а не `0.0.0.0:27042`.

## Экосистема

| Репозиторий | Роль |
|---|---|
| [Florida](https://github.com/cergo666/Florida) | сборка `florida-server` / gadget / inject |
| **MagiskHluda** (этот) | Magisk / KernelSU / APatch-модуль, старт на boot |
| [Ylarod/Florida](https://github.com/Ylarod/Florida) | исходный форк |

## Установка

1. Скачайте ZIP с [Releases](https://github.com/cergo666/MagiskHluda/releases) под архитектуру устройства или universal-пакет.
2. Поставьте через Magisk / KernelSU / KSUN / APatch.

Архитектуры: `arm64`, `arm`, `x86`, `x86_64`.

Обновления модуля проверяются по расписанию CI (~каждые 12 часов), когда выходит новый релиз Florida.

## Подключение

Порт печатается при установке и лежит в `/data/adb/modules/magisk-hluda/module.cfg`:

```bash
adb forward tcp:<port> tcp:<port>
frida-ps -H 127.0.0.1:<port>
```

`frida -U` по-прежнему ходит в `tcp:27042` на устройстве. Либо в Web UI выставьте `0.0.0.0:27042`, либо оставьте стелс-дефолты и используйте `-H`, как выше.

Подробнее: [troubleshooting.md](troubleshooting.md).

## Web UI

В Magisk / KSU можно открыть веб-интерфейс модуля:

- старт / стоп сервера;
- статус;
- порт и адрес listen;
- дополнительные параметры CLI.

Остановка Florida **может уронить System UI**. Сохраните работу перед стопом.

## Сборка

Упаковщик скачивает `florida-server` и `identities.json` с [cergo666/Florida](https://github.com/cergo666/Florida).

```bash
./vcpkg install rapidjson restclient-cpp
cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=vcpkg/scripts/buildsystems/vcpkg.cmake
cmake --build build --config Release
./build/MagiskHluda
```

## Тесты

```bash
sh tests/test_scripts.sh
```

CI гоняет эти проверки на каждый push.

## Ограничения

Florida убирает известные **строки** в бинарнике. Inline-хуки и сверка `.text` с диском так не спрятать. Если Florida всё ещё ловят, можно смотреть в сторону [ZygiskFrida](https://github.com/lico-n/ZygiskFrida).

## Ссылки

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
