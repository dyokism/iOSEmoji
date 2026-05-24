#!/system/bin/sh
# ios_emoji - customize.sh
# universal installation for android devices

ui_print "[+] iOS Emoji"
ui_print "[+] Preparing iOS 26.4 Emoji for \$(getprop ro.product.model)"

# bypass android 12+ font ota engine
if [ -d "/data/fonts" ]; then
    ui_print "[+] Cleared Android OTA font directory (/data/fonts)"
    rm -rf "/data/fonts"
fi

# systemless overlay mounting
# handled automatically by mountifynext
ui_print "[+] Copying iOS Emojis to system..."

# Set standard permissions
set_perm_recursive "$MODPATH" 0 0 0755 0644

ui_print "[+] Done! Reboot to apply emojis systemlessly & stealthily."
