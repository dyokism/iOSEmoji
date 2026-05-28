## Change Log:
- 1.1 (Universal Stability Update)
  - Added robust `uninstall.sh` to fully restore GMS font providers, Facebook patches, and Messenger paths upon removal.
  - Implemented dynamic root verification (Magisk/KSU/APatch) and Android API compatibility checks.
  - Fulfilled dynamic phone profiling: installer now greets the user and logs details.
  - Added `post-fs-data.sh` early boot hook to block GMS font OTA race conditions.
  - Added 5-minute timeout protection in boot-wait loops to prevent loop hangs.
  - Bumped version to 1.1 and optimized repository structures.

- 1.0 (Initial Release - Universal iOS Emoji)
  - Universal compatibility for both Samsung and standard non-Samsung Android devices.
  - Dynamically detects and greets the user's specific phone model during installation (Implemented in v1.1).
  - Includes latest iOS 26.4 Emojis (NotoColorEmoji and SamsungColorEmoji).
  - Automatically bypasses Android 12+ GMS Font OTA overrides on every boot.
  - In-app direct patching support for Facebook, Messenger, and Facebook Lite.
  - Secures and locks Messenger font paths to block background OTA emoji reverts.
  - Full systemless and stealthy deployment (hidden via MountifyNext).
