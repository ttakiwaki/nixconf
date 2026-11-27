#!/bin/bash
# Dim the icon when Bluetooth is switched off (reads the system Bluetooth power state).

STATE=$(defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState 2>/dev/null)

if [ "$STATE" = "0" ]; then
  sketchybar --set "$NAME" icon.color=0x80ffffff
else
  sketchybar --set "$NAME" icon.color=0xffe8e8e8
fi
