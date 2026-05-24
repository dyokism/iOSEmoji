[English](README.md) | [Bahasa Indonesia](README.id.md)

# iOS Emoji

**Bring the latest iOS 26.4 Emojis to any Android device systemlessly.**

![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Android](https://img.shields.io/badge/Android-8.0%2B-green.svg)
![Version](https://img.shields.io/badge/Version-1.0-orange.svg)
![Root](https://img.shields.io/badge/Root-Magisk%20%7C%20KernelSU%20%7C%20APatch-red.svg)

## Overview

iOS Emoji is a Magisk/KernelSU/APatch module that installs Apple iOS 26.4 Emojis globally on any Android device. Using dynamic device profiling, it detects your device model during installation and configures the font rendering systemlessly and stealthily.

### How It Works

- **Dual-Font Configuration**: Bundles both `NotoColorEmoji.ttf` (standard Android) and `SamsungColorEmoji.ttf` (One UI Samsung) for 100% universal compatibility across all OEM brands.
- **Android 12+ Font OTA Bypass**: Clears `/data/fonts` and disables Google Font OTA provider packages on every boot to prevent system updates from reverting your emojis.
- **In-App Emoji Direct-Patching**: Direct-patches the internal emoji files for Facebook, Messenger, and Facebook Lite apps.
- **Messenger OTA Font Blocking**: Blocks Facebook Messenger from overriding iOS emojis by locking its OTA fonts path using a secure system chmod trick.
- **Stealth Mounts**: Best used in combination with **MountifyNext** to completely hide the root modifications from banking apps (e.g., BRImo).

---

## Requirements

| Requirement | Details |
|-------------|---------|
| Android | 8.0+ (API 26+) |
| Root | Magisk v20.4+, KernelSU, or APatch |

---

## Installation

1. Download the latest release ZIP from the repository.
2. Open Magisk, KernelSU, or APatch manager.
3. Install the ZIP via the **Modules** tab.
4. **Reboot** your device to apply the emojis.

---

## Developer & License

- **Developer**: [dyokism](https://github.com/dyokism)
- **License**: MIT License
