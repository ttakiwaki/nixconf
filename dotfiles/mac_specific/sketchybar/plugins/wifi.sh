#!/bin/bash
# ~/.config/sketchybar/plugins/wifi.sh

# Nerd Font glyphs as raw UTF-8 bytes (safe on macOS bash 3.2)
WIFI_CONNECTED=$'\xef\x87\xab'    # standard wifi icon
WIFI_OFFLINE=$'\xf3\xb0\x96\xaa'      # wifi with crossthrough/slash

if [ -n "$(ipconfig getifaddr en0 2>/dev/null)" ]; then
  sketchybar --set "$NAME" icon="$WIFI_CONNECTED" icon.color=0xffe8e8e8
else
  # Uses dim grey; you can also use 0xfff38ba8 (accent red from battery.sh) for alert visibility
  sketchybar --set "$NAME" icon="$WIFI_OFFLINE" icon.color=0x80ffffff
fi
