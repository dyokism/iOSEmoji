#!/system/bin/sh
# ios_emoji - uninstall.sh
# restore GMS fonts provider and Messenger chmod/patches

LOG_FILE="/data/adb/modules/iOS_Emoji/uninstall.log"
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

log "iOS Emoji uninstall started"

# re-enable gms font providers for numeric users
GMS_PROVIDER="com.google.android.gms/com.google.android.gms.fonts.provider.FontsProvider"
GMS_UPDATER="com.google.android.gms/com.google.android.gms.fonts.update.UpdateSchedulerService"

for user_dir in /data/user/*; do
    uid=${user_dir##*/}
    if echo "$uid" | grep -qE '^[0-9]+$'; then
        pm enable --user "$uid" "$GMS_PROVIDER" >/dev/null 2>&1
        pm enable --user "$uid" "$GMS_UPDATER" >/dev/null 2>&1
    fi
done
log "GMS Font OTA engines re-enabled"

# restore messenger font path
orca_dir="/data/data/com.facebook.orca/files/fonts"
if [ -d "$orca_dir" ]; then
    chmod 700 "$orca_dir" 2>/dev/null
    rm -rf "$orca_dir" 2>/dev/null
fi
log "Restored Messenger font paths"

# delete direct-patched Facebook/Messenger font files
FACEBOOK_APPS="com.facebook.orca com.facebook.katana com.facebook.lite com.facebook.mlite"
for pkg in $FACEBOOK_APPS; do
    if [ "$pkg" = "com.facebook.lite" ] || [ "$pkg" = "com.facebook.mlite" ]; then
        rm -f "/data/data/$pkg/files/emoji_font.ttf" 2>/dev/null
    else
        rm -f "/data/data/$pkg/app_ras_blobs/FacebookEmoji.ttf" 2>/dev/null
    fi
    am force-stop "$pkg" 2>/dev/null
done
log "Removed in-app Facebook/Messenger emoji patches"

# clear GMS leftover fonts to trigger system font reloading
rm -rf /data/fonts 2>/dev/null
rm -rf /data/data/com.google.android.gms/files/fonts 2>/dev/null

log "iOS Emoji uninstall completed"
exit 0
