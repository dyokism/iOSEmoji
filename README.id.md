[English](README.md) | [Bahasa Indonesia](README.id.md)

# iOS Emoji

**Bawa tampilan Emoji iOS 26.4 terbaru ke semua perangkat Android secara systemless.**

![Lisensi](https://img.shields.io/badge/Lisensi-MIT-blue.svg)
![Android](https://img.shields.io/badge/Android-8.0%2B-green.svg)
![Versi](https://img.shields.io/badge/Versi-1.1-orange.svg)
![Root](https://img.shields.io/badge/Root-Magisk%20%7C%20KernelSU%20%7C%20APatch-red.svg)

## Ringkasan

iOS Emoji adalah modul Magisk/KernelSU/APatch yang memasang Emoji Apple iOS 26.4 secara global di seluruh sistem perangkat Android apa pun. Dengan fitur dinamis, modul ini mendeteksi model HP Anda secara otomatis saat instalasi dan mengonfigurasi rendering emoji secara senyap dan bersih dari deteksi root.

### Cara Kerja

- **Dukungan Font Ganda**: Menyediakan berkas `NotoColorEmoji.ttf` (untuk standard Android) dan `SamsungColorEmoji.ttf` (untuk One UI Samsung) agar kompatibel 100% di semua merk HP.
- **Bypass Mesin Font OTA Android 12+**: Membersihkan direktori `/data/fonts` dan menonaktifkan paket GMS Font OTA di setiap boot untuk mencegah sistem menimpa kembali emoji kustom Anda.
- **Tambalan Emoji Dalam-Aplikasi**: Secara otomatis menambal berkas emoji internal bawaan untuk aplikasi Facebook, Messenger, dan Facebook Lite.
- **Kunci Unduhan OTA Messenger**: Mengunci jalur unduhan font otomatis pada aplikasi Facebook Messenger menggunakan trik keamanan chmod sistem.

---

## Persyaratan

| Persyaratan | Detail |
|-------------|--------|
| Android | 8.0+ (API 26+) |
| Root | Magisk v20.4+, KernelSU, atau APatch |

---

## Instalasi

1. Unduh file ZIP rilis terbaru dari repositori.
2. Buka aplikasi Magisk, KernelSU, atau APatch manager.
3. Instal file ZIP melalui tab **Modules**.
4. **Reboot** perangkat Anda untuk menerapkan emoji secara global.

---

## Pengembang & Lisensi

- **Pengembang**: [dyokism](https://github.com/dyokism)
- **Lisensi**: MIT
