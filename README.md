[English](README.md) | [Bahasa Indonesia](README.id.md)

# iOS Emoji

**Replace system emojis with the latest iOS Emojis on Android.**

![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Android](https://img.shields.io/badge/Android-8.0%2B-green.svg)
![Version](https://img.shields.io/badge/Version-1.2-orange.svg)
![Root](https://img.shields.io/badge/Root-Magisk%20%7C%20KernelSU%20%7C%20APatch-red.svg)

## Overview

iOS Emoji is a root module designed to globally apply Apple iOS Emojis across Android devices. By incorporating dual-font assets (`NotoColorEmoji.ttf` and `SamsungColorEmoji.ttf`), it ensures compatibility on both One UI and stock Android emoji layouts.

---

## Why Use iOSEmoji?

- **Universal Compatibility**: Works automatically on both stock Android and Samsung One UI devices.
- **Permanent Application**: Blocks automatic system updates from reverting your custom emojis.
- **Broad App Support**: Applies emojis globally, including within popular social apps and keyboard inputs.

---

## Requirements

| Requirement | Details |
|-------------|---------|
| Android | 8.0+ (API 26+) |
| Target Apps | Facebook, Messenger, Facebook Lite, Gboard |
| Root | Magisk v20.4+, KernelSU, or APatch |

---

## Installation

1. Install the module ZIP via your root manager's **Modules** tab (Magisk, KernelSU, or APatch).
2. **Reboot** your device to apply the new iOS emoji layout globally.

---

## How It Works

```mermaid
flowchart TD
    FlashZip([Start: Flash Module ZIP]) --> CheckRoot{Check Root App?}
    CheckRoot -- Unsupported --> AbortRoot[Abort: Recovery Not Supported]
    CheckRoot -- Supported --> CheckAPI{Check Android API Level?}
    
    CheckAPI -- API < 26 --> AbortAPI[Abort: Requires Android 8.0+]
    CheckAPI -- API >= 26 --> ProfileDevice[Profile Device Model & Brand]
    
    ProfileDevice --> DetectBrand{Is Samsung Device?}
    DetectBrand -- Yes --> SelectSamsung[Select SamsungColorEmoji.ttf]
    DetectBrand -- No --> SelectNoto[Select NotoColorEmoji.ttf]
    
    SelectSamsung & SelectNoto --> ClearOTAFonts[Clear OTA Font Cache in /data/fonts]
    ClearOTAFonts --> SetPerms[Set Standard Permissions & Complete]
    
    SetPerms --> BootStart[Device Reboots & Early Boot Post-FS]
    BootStart --> ClearOTAEarly[Clear /data/fonts Directory]
    ClearOTAEarly --> WaitBoot[Wait for sys.boot_completed=1 in service.sh]
    
    WaitBoot --> PatchFB{Patch In-App Emojis?}
    PatchFB -- Yes --> CopyFB[Copy Source Font to Facebook/Messenger paths]
    CopyFB --> BlockMessenger[Block Messenger OTA Font Downloads via chmod 000]
    PatchFB -- No/Skip --> ClearGboard[Clear Gboard Cache & Force Stop]
    BlockMessenger --> ClearGboard
    
    ClearGboard --> DisableGMS[Disable GMS Font OTA Engine & Update Services]
    DisableGMS --> ClearGMSCache[Cleanup GMS Leftover Fonts]
    ClearGMSCache --> LogComplete[Log Service Completion]
    LogComplete --> Finished([Finished: iOS Emojis Applied Successfully])

    %% Custom Styles and Colors (Ultra-Muted Slate Theme)
    classDef startEnd fill:#1b2c24,stroke:#34d399,stroke-width:1.5px,color:#e6f4ea;
    classDef fail fill:#2c1b1b,stroke:#f87171,stroke-width:1.5px,color:#fce8e6;
    classDef decision fill:#2d2216,stroke:#fbbf24,stroke-width:1.5px,color:#fef3c7;
    classDef process fill:#1e293b,stroke:#475569,stroke-width:1px,color:#f1f5f9;
    
    class FlashZip,Finished startEnd;
    class AbortRoot,AbortAPI fail;
    class CheckRoot,CheckAPI,DetectBrand,PatchFB decision;
    class ProfileDevice,SelectSamsung,SelectNoto,ClearOTAFonts,SetPerms,BootStart,ClearOTAEarly,WaitBoot,CopyFB,BlockMessenger,ClearGboard,DisableGMS,ClearGMSCache,LogComplete process;
```

---

## Developer & License

- **Developer**: [dyokism](https://github.com/dyokism)
- **License**: MIT
