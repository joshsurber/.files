#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run picom
run nm-applet
run blueman-applet
run nitrogen --restore
# run pcmanfm --desktop
run pcmanfm -d
run volumeicon
run xscreensaver --no-splash
setxkbmap -option caps:escape
