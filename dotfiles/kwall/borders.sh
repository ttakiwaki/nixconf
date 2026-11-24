#!/bin/sh
# Sets JankyBorders colors from pywal: lighter color top-left, darker bottom-right
. "$HOME/.cache/wal/colors.sh"

a=${color4#\#}
b=${color5#\#}
inactive=${color0#\#}

# Rough brightness of a hex color (0-255)
lum() {
  r=$(printf '%d' "0x$(echo "$1" | cut -c1-2)")
  g=$(printf '%d' "0x$(echo "$1" | cut -c3-4)")
  bl=$(printf '%d' "0x$(echo "$1" | cut -c5-6)")
  echo $(( (299 * r + 587 * g + 114 * bl) / 1000 ))
}

if [ "$(lum "$a")" -ge "$(lum "$b")" ]; then light=$a; dark=$b; else light=$b; dark=$a; fi

borders "active_color=gradient(top_left=0xff${light},bottom_right=0xff${dark})" \
        "inactive_color=0xff${inactive}" >/dev/null 2>&1
