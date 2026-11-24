#!/bin/bash
# ~/.config/sketchybar/plugins/marquee.sh
# Animation helper, started by sketchybarrc (one background process).
# Scrolls long text in the bar label and popup title/artist only when hovered.
# Reads the current track from /tmp/sketchybar-media.state (written by media.sh).
# Text limits are in display cells: Latin = 1 cell, Japanese/Chinese/Korean = 2 cells.

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export LC_ALL="${MARQUEE_LOCALE:-en_US.UTF-8}"   # so string slicing counts characters, not bytes

STATE="/tmp/sketchybar-media.state"
HOVER_FLAG="/tmp/sketchybar-media-hover"

# ---- text limits (cells) ----
#   BAR_N: bar label. ~55 cells reaches about 3/4 of the way from the left screen edge to the notch.
#   TITLE_N / ARTIST_N: popup lines; keep TITLE_N <= 18 so it stays clear of the edges.
BAR_N=55
TITLE_N=18
ARTIST_N=20
SEP="     "    # gap between the end of the text and where it wraps around

CW=0
cellw() {   # cellw <text> -> sets CW to its display width (wide characters count 2)
  local s="$1" o="$LC_ALL" chars bytes
  chars=${#s}
  LC_ALL=C
  bytes=${#s}
  LC_ALL="$o"
  # ASCII = 1 byte/1 cell, CJK = 3 bytes/2 cells  ->  cells = (bytes + chars) / 2
  CW=$(( (bytes + chars) / 2 ))
}

RES=""
window() {   # window <text> <max cells> <position> -> sets RES
  local t="$1" n="$2" p="$3" loop s len start k cand
  cellw "$t"
  if [ "$CW" -le "$n" ]; then
    RES="$t"
    return
  fi
  loop="$t$SEP"
  len=${#loop}
  s="$loop$loop"
  start=$(( p % len ))
  k=$n
  cand="${s:$start:$k}"
  cellw "$cand"
  while [ "$CW" -gt "$n" ] && [ "$k" -gt 1 ]; do
    k=$((k - 1))
    cand="${s:$start:$k}"
    cellw "$cand"
  done
  RES="$cand"
}

main() {
  local pos=0 last_state="" last_out="" tick=0
  local L T A P cur BL BT BA out wide

  while true; do
    tick=$((tick + 1))
    # exit when sketchybar is gone (checked about every 15 seconds)
    if [ $((tick % 100)) -eq 0 ] && ! pgrep -x sketchybar >/dev/null; then
      exit 0
    fi

    L=""; T=""; A=""; P=""
    { IFS= read -r L; IFS= read -r T; IFS= read -r A; IFS= read -r P; } < "$STATE" 2>/dev/null

    if [ -z "$L" ]; then
      sleep 1
      continue
    fi

    cur="$L|$T|$A"
    if [ "$cur" != "$last_state" ]; then
      pos=0
      last_state="$cur"
    fi

    # Check if any label exceeds its cell display limit
    wide=0
    cellw "$L"; [ "$CW" -gt $BAR_N ] && wide=1
    cellw "$T"; [ "$CW" -gt $TITLE_N ] && wide=1
    cellw "$A"; [ "$CW" -gt $ARTIST_N ] && wide=1

    window "$L" $BAR_N $pos;    BL="$RES"
    window "$T" $TITLE_N $pos;  BT="$RES"
    window "$A" $ARTIST_N $pos; BA="$RES"

    out="$BL$BT$BA"
    if [ "$out" != "$last_out" ]; then
      sketchybar --set media label="$BL" \
                 --set media.title label="$BT" \
                 --set media.artist label="$BA"
      last_out="$out"
    fi

    # Only scroll when playing, text exceeds width, and the mouse is hovering
    if [ "$P" = "true" ] && [ "$wide" = 1 ] && [ -f "$HOVER_FLAG" ]; then
      pos=$((pos + 1))
      sleep 0.3
    else
      pos=0
      sleep 0.6
    fi
  done
}

# run the loop only when executed directly (lets the functions be sourced for testing)
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  main
fi
