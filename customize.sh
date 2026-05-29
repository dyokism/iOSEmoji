#!/system/bin/sh
# shellcheck disable=SC3043,SC2181
# ios_emoji - customize.sh
# universal installation for android devices with advanced profiling

INSTALL_LOG="$MODPATH/install.log"
log() {
  echo "$(date '+%H:%M:%S') $1" >> "$INSTALL_LOG"
}
log "=== iOS Emoji installation started ==="

ui_print "*****************************************"
ui_print "        iOS Emoji Installer v1.2         "
ui_print "*****************************************"

# check root type
ui_print "- Checking root implementation"
if [ "$BOOTMODE" ] && [ "$KSU" ]; then
  ui_print "  Installing from KernelSU app"
  log "Root: KernelSU"
elif [ "$BOOTMODE" ] && [ "$APATCH" ]; then
  ui_print "  Installing from APatch app"
  log "Root: APatch"
elif [ "$BOOTMODE" ] && [ "$MAGISK_VER_CODE" ]; then
  ui_print "  Installing from Magisk app"
  log "Root: Magisk"
else
  ui_print "  Recovery installation is not supported!"
  abort "  Aborting!"
fi

# check android api
if [ "$API" -lt 26 ]; then
  abort "- Unsupported Android version: API $API (requires Android 8.0+ / API 26+)"
fi
ui_print "- Android API Level: $API"
log "API: $API"

# profiling phone model
brand="$(getprop ro.product.brand)"
model="$(getprop ro.product.model)"
ui_print "- Device: $brand ($model)"
log "Device brand: $brand, Model: $model"

# samsung-specific optimization log
if echo "$brand" | grep -qi "samsung"; then
  ui_print "- Mounting SamsungColorEmoji.ttf..."
  log "Selected SamsungColorEmoji.ttf for Samsung device"
else
  ui_print "- Mounting NotoColorEmoji.ttf..."
  log "Selected NotoColorEmoji.ttf for standard rendering"
fi

# bypass android 12+ font ota engine
if [ -d "/data/fonts" ]; then
    ui_print "- Cleared Android OTA font directory (/data/fonts)"
    rm -rf "/data/fonts"
    log "Cleared OTA /data/fonts"
fi

# set standard permissions
ui_print "- Setting file permissions..."
set_perm_recursive "$MODPATH" 0 0 0755 0644
log "Permissions set"

ui_print "- Reboot to apply."
log "=== iOS Emoji installation completed ==="
