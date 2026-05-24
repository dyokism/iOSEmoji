#!/system/bin/sh
# ios_emoji - service.sh
# run lightweight boot hooks optimized for all android devices

MODPATH=${0%/*}
LOGFILE="$MODPATH/service.log"
SRC_FONT="$MODPATH/system/fonts/NotoColorEmoji.ttf"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOGFILE"
}

# wait for boot completion
until [ "$(getprop sys.boot_completed)" = "1" ] && [ -d /sdcard ]; do
    sleep 2
done

log "iOS Emoji: boot completed"

# direct target messenger & facebook emojis
FACEBOOK_APPS="com.facebook.orca com.facebook.katana com.facebook.lite com.facebook.mlite"

for pkg in $FACEBOOK_APPS; do
    if [ -d "/data/data/$pkg" ]; then
        if [ "$pkg" = "com.facebook.lite" ] || [ "$pkg" = "com.facebook.mlite" ]; then
            target_dir="/data/data/$pkg/files"
            target_file="$target_dir/emoji_font.ttf"
        else
            target_dir="/data/data/$pkg/app_ras_blobs"
            target_file="$target_dir/FacebookEmoji.ttf"
        fi
        
        mkdir -p "$target_dir"
        cp -f "$SRC_FONT" "$target_file" 2>/dev/null
        chmod 444 "$target_file" 2>/dev/null
        log "Direct-patched in-app emoji for $pkg"
    fi
done

# block messenger font ota downloads (chmod 000 trick)
for orca_dir in "/data/data/com.facebook.orca/files/fonts" "/data/user/0/com.facebook.orca/files/fonts"; do
    if [ -d "/data/data/com.facebook.orca" ]; then
        rm -rf "$orca_dir" 2>/dev/null
        mkdir -p "$orca_dir"
        chmod 000 "$orca_dir"
        log "Blocked Messenger font cache path: $orca_dir"
    fi
done

# clear gboard cache
GBOARD_PKG="com.google.android.inputmethod.latin"
if [ -d "/data/data/$GBOARD_PKG" ]; then
    for subpath in /cache /code_cache /app_webview; do
        rm -rf "/data/data/${GBOARD_PKG}${subpath}" 2>/dev/null
    done
    am force-stop "$GBOARD_PKG"
    log "Cleared Gboard cache & force-stopped"
fi

# force-stop facebook apps to apply changes
for pkg in $FACEBOOK_APPS; do
    [ -d "/data/data/$pkg" ] && am force-stop "$pkg"
done
log "Force-stopped Facebook/Messenger apps"

# disable gms font provider (prevents ota override)
GMS_PROVIDER="com.google.android.gms/com.google.android.gms.fonts.provider.FontsProvider"
GMS_UPDATER="com.google.android.gms/com.google.android.gms.fonts.update.UpdateSchedulerService"

for user_dir in /data/user/*; do
    uid=${user_dir##*/}
    pm disable --user "$uid" "$GMS_PROVIDER" >/dev/null 2>&1
    pm disable --user "$uid" "$GMS_UPDATER" >/dev/null 2>&1
done
log "GMS Font OTA engines disabled"

# cleanup gms leftover fonts
rm -rf /data/fonts 2>/dev/null
rm -rf /data/data/com.google.android.gms/files/fonts 2>/dev/null
log "OTA font caches cleared"
