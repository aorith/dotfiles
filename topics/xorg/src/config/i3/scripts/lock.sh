#!/bin/bash
img_path="/tmp/.i3lock.png"
overlay_path="${HOME}/.config/i3/scripts/overlay.png"
resolution="$(xdpyinfo | awk '/dimensions/{print $2}')"
convert "$overlay_path" -resize "$resolution" "/tmp/.i3lock_overlay.png"
ffmpeg -f x11grab -video_size "$resolution" -y -i $DISPLAY -i "/tmp/.i3lock_overlay.png" -filter_complex "boxblur=5:1,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 "$img_path" -loglevel quiet
i3lock -i "$img_path"
rm "$img_path" 2>/dev/null
