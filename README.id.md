[English](README.md) | [Bahasa Indonesia](README.id.md)

# iOS Emoji

**Ganti emoji bawaan dengan emoji iOS terbaru secara global di perangkat Android.**

![Lisensi](https://img.shields.io/badge/Lisensi-MIT-blue.svg)
![Android](https://img.shields.io/badge/Android-8.0%2B-green.svg)
![Versi](https://img.shields.io/badge/Versi-1.2-orange.svg)
![Root](https://img.shields.io/badge/Root-Magisk%20%7C%20KernelSU%20%7C%20APatch-red.svg)

## Deskripsi Umum

iOS Emoji adalah modul root yang dirancang untuk memasang Emoji Apple iOS secara global pada sistem Android. Dengan menyertakan berkas font ganda (`NotoColorEmoji.ttf` dan `SamsungColorEmoji.ttf`), modul ini menjamin kompatibilitas baik pada perangkat bersistem One UI (Samsung) maupun Android standar.

---

## Mengapa Memilih iOS Emoji?

- **Kompatibilitas Luas**: Berfungsi otomatis baik di sistem Android standar maupun perangkat Samsung One UI.
- **Permanen & Stabil**: Mencegah sistem memulihkan kembali emoji bawaan secara otomatis.
- **Dukungan Aplikasi Populer**: Emoji diterapkan secara menyeluruh, termasuk di aplikasi sosial dan keyboard Anda.

---

## Persyaratan Sistem

| Persyaratan | Detail |
|-------------|--------|
| Android | 8.0+ (API 26+) |
| Aplikasi Target | Facebook, Messenger, Facebook Lite, Gboard |
| Root | Magisk v20.4+, KernelSU, atau APatch |

---

## Instalasi

1. Pasang berkas ZIP modul melalui tab **Modules** di manajer root Anda (Magisk, KernelSU, atau APatch).
2. **Reboot** (Mulai ulang) perangkat Anda untuk menerapkan emoji iOS baru secara global.

---

## Cara Kerja

```mermaid
flowchart TD
    FlashZip([Mulai: Flash ZIP Modul]) --> CheckRoot{Cek Tipe Root?}
    CheckRoot -- Tidak Didukung --> AbortRoot[Abort: Recovery Tidak Didukung]
    CheckRoot -- Didukung --> CheckAPI{Cek Level API Android?}
    
    CheckAPI -- API < 26 --> AbortAPI[Abort: Butuh Android 8.0+]
    CheckAPI -- API >= 26 --> ProfileDevice[Profil Perangkat & Merek HP]
    
    ProfileDevice --> DetectBrand{Merek HP Samsung?}
    DetectBrand -- Ya --> SelectSamsung[Gunakan SamsungColorEmoji.ttf]
    DetectBrand -- Tidak --> SelectNoto[Gunakan NotoColorEmoji.ttf]
    
    SelectSamsung & SelectNoto --> ClearOTAFonts[Bersihkan Cache Font OTA di /data/fonts]
    ClearOTAFonts --> SetPerms[Atur Izin File & Selesai]
    
    SetPerms --> BootStart[Perangkat Mulai Ulang & Boot Awal Post-FS]
    BootStart --> ClearOTAEarly[Hapus Direktori /data/fonts Awal]
    ClearOTAEarly --> WaitBoot[Tunggu Hingga sys.boot_completed=1 di service.sh]
    
    WaitBoot --> PatchFB{Tambal Aplikasi Facebook/Messenger?}
    PatchFB -- Ya --> CopyFB[Salin Font ke Jalur Facebook/Messenger]
    CopyFB --> BlockMessenger[Kunci Unduhan Font OTA Messenger via chmod 000]
    PatchFB -- Tidak --> ClearGboard[Bersihkan Cache Gboard & Force Stop]
    BlockMessenger --> ClearGboard
    
    ClearGboard --> DisableGMS[Nonaktifkan Mesin GMS Font OTA & Layanan Update]
    DisableGMS --> ClearGMSCache[Bersihkan Sisa Berkas Cache Font GMS]
    ClearGMSCache --> LogComplete[Catat Log Penyelesaian Layanan]
    LogComplete --> Finished([Selesai: Emoji iOS Diterapkan Stabil])

    %% Kustomisasi Tampilan dan Warna (Tema Gelap Ultra-Redup)
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

## Pengembang & Lisensi

- **Pengembang**: [dyokism](https://github.com/dyokism)
- **Lisensi**: MIT
