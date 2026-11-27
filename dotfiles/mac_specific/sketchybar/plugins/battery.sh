#!/bin/bash

BATT=$(pmset -g batt)
PCT=$(echo "$BATT" | grep -Eo '[0-9]+%' | head -1 | tr -d '%')
[ -z "$PCT" ] && exit 0

# Nerd Font battery glyphs (UTF-8 bytes)
FULL=$'\xef\x89\x80'
THREEQ=$'\xef\x89\x81'
HALF=$'\xef\x89\x82'
QUARTER=$'\xef\x89\x83'
EMPTY=$'\xef\x89\x84'
BOLT=$'\xef\x83\xa7'

COLOR=0xffe8e8e8

if echo "$BATT" | grep -q 'AC Power'; then
  ICON="$BOLT"
else
  if   [ "$PCT" -ge 88 ]; then ICON="$FULL"
  elif [ "$PCT" -ge 63 ]; then ICON="$THREEQ"
  elif [ "$PCT" -ge 38 ]; then ICON="$HALF"
  elif [ "$PCT" -ge 13 ]; then ICON="$QUARTER"
  else ICON="$EMPTY"
  fi
  [ "$PCT" -le 20 ] && COLOR=0xfff38ba8
fi

sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label="${PCT}%"
