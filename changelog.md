## Change Log:
- 1.2 (Code Quality & Universal Refactoring)
  - Fixed syntax bugs (removed invalid global `local` variable declarations).
  - Cleaned up installer output tone & wording for a more premium experience.
  - Resolved double "Done" notifications by deferring to the package manager's status.
  - Added background boot service completion logging for easier debugging.
  - Standardized all codebase comments and cleaned up redundant documentation terms.
  - Disabled installer active execution tracing (`set -x`) in production builds.

- 1.1 (Universal Stability Update)
  - Added robust `uninstall.sh` to fully restore GMS font providers, Facebook patches, and Messenger paths upon removal.
  - Implemented dynamic root verification (Magisk/KSU/APatch) and Android API compatibility checks.
  - Fulfilled dynamic phone profiling: installer now detects the device and logs details.
  - Added `post-fs-data.sh` early boot hook to block GMS font OTA race conditions.
  - Added 5-minute timeout protection in boot-wait loops to prevent loop hangs.
  - Bumped version to 1.1 and optimized repository structures.

- 1.0 (Initial Release - Universal iOS Emoji)
  - Universal compatibility for both Samsung and standard Android devices.
  - Includes latest iOS 26.4 Emojis (NotoColorEmoji and SamsungColorEmoji).
  - Automatically bypasses Android 12+ GMS Font OTA overrides on every boot.
  - In-app direct patching support for Facebook, Messenger, and Facebook Lite.
  - Secures and locks Messenger font paths to block background OTA emoji reverts.
  - Full systemless and stealthy deployment.
