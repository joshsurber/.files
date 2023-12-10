#!/bin/sh

# run() {
#     if ! pgrep -f "$1"; then
#         "$@" &
#     fi
# }

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run picom
run nm-applet
# run blueman-applet
# run cbatticon
run nitrogen --restore
# run pcmanfm --desktop
# run pcmanfm -d
# run volumeicon
run xscreensaver --no-splash
# run setxkbmap -option caps:escape
# setxkbmap us -variant colemak
run clipmenud
