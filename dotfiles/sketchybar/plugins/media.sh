#!/bin/bash
# Needs: media-control + jq
# Polls now-playing, updates the icon/colors/popup art, and writes the track text to a state
# file; marquee.sh turns that into the (scrolling) labels.

# sketchybar runs plugins with a minimal PATH; make brew tools findable
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

NOTE=$'\xef\x80\x81'    # music note
PLAY=$'\xef\x81\x8b'    # play
PAUSE=$'\xef\x81\x8c'   # pause

ART_DIR="/tmp/sketchybar-art"
KEY_FILE="/tmp/sketchybar-media.key"
STATE="/tmp/sketchybar-media.state"
mkdir -p "$ART_DIR"

write_state() {   # write_state <bar label> <title> <artist> <playing|idle>
  printf '%s\n%s\n%s\n%s\n' "$1" "$2" "$3" "$4" > "$STATE.tmp" && mv "$STATE.tmp" "$STATE"
}

idle() {
  write_state "No Music" "No Music" "" "idle"
  sketchybar --set "$NAME" icon="$NOTE" icon.color=0x80ffffff label.color=0x80ffffff \
             --set media.cover drawing=off \
             --set media.cover_ph drawing=on \
             --set media.play icon="$PLAY"
  rm -f "$KEY_FILE"
  exit 0
}

JSON=$(media-control get 2>/dev/null)

if [ -z "$JSON" ] || [ "$JSON" = "null" ]; then
  idle
fi

TITLE=$(echo "$JSON" | jq -r '.title // empty')
ARTIST=$(echo "$JSON" | jq -r '.artist // empty')
ALBUM=$(echo "$JSON" | jq -r '.album // empty')
PLAYING=$(echo "$JSON" | jq -r '.playing // false')

if [ -z "$TITLE" ]; then
  idle
fi

LABEL="$TITLE"
[ -n "$ARTIST" ] && LABEL="$ARTIST - $TITLE"

if [ "$PLAYING" = "true" ]; then
  ICON="$NOTE"
  COLOR=0xffe8e8e8
  PP_ICON="$PAUSE"
else
  ICON="$NOTE"
  COLOR=0x80ffffff
  PP_ICON="$PLAY"
fi

write_state "$LABEL" "$TITLE" "$ARTIST" "$PLAYING"

HOVER_FLAG="/tmp/sketchybar-media-hover"

case "$SENDER" in
  mouse.entered)
    touch "$HOVER_FLAG"
    exit 0
    ;;
  mouse.exited)
    rm -f "$HOVER_FLAG"
    exit 0
    ;;
esac

# ---- album art: decode once per track, resize to 300px, cache ----
KEY=$(md5 -qs "$ARTIST|$ALBUM|$TITLE")
ART_FILE="$ART_DIR/$KEY.png"

if [ ! -f "$ART_FILE" ]; then
  DATA=$(echo "$JSON" | jq -r '.artworkData // empty')
  if [ -n "$DATA" ]; then
    MIME=$(echo "$JSON" | jq -r '.artworkMimeType // empty')
    case "$MIME" in
      *png*) EXT=png ;;
      *)     EXT=jpg ;;
    esac
    RAW="$ART_DIR/$KEY.raw.$EXT"
    echo "$DATA" | base64 -D > "$RAW" 2>/dev/null
    sips -s format png -Z 300 "$RAW" --out "$ART_FILE" >/dev/null 2>&1
    rm -f "$RAW"
    # drop cached art older than a day
    find "$ART_DIR" -name '*.png' -mtime +1 -delete 2>/dev/null
  fi
fi

# track whether art is actually ready and rendered to catch delayed Spotify loads
if [ -f "$ART_FILE" ]; then
  CURRENT_STATE="$KEY:art"
else
  CURRENT_STATE="$KEY:noart"
fi

LAST_STATE=$(cat "$KEY_FILE" 2>/dev/null)
ART_ARGS=()
if [ "$CURRENT_STATE" != "$LAST_STATE" ]; then
  if [ -f "$ART_FILE" ]; then
    ART_ARGS=(--set media.cover drawing=on background.image="$ART_FILE" \
              --set media.cover_ph drawing=off)
  else
    ART_ARGS=(--set media.cover drawing=off --set media.cover_ph drawing=on)
  fi
  echo "$CURRENT_STATE" > "$KEY_FILE"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label.color=0xffe8e8e8 \
           --set media.play icon="$PP_ICON" \
           "${ART_ARGS[@]}"
