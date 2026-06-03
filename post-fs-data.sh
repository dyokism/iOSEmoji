#!/system/bin/sh
# clear ota fonts safely
if [ -d /data/fonts ] && [ ! -L /data/fonts ]; then
    rm -rf /data/fonts
fi
