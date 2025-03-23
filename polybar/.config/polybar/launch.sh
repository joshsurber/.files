#! /bin/bash

# Terminate already running bar instances
# killall -q polybar
# If all your bars have ipc enabled, you can also use
polybar-msg cmd quit 2>/dev/null

# polybar -r only 2>&1 | tee -a /tmp/polybar.log & disown

if [[ $(xrandr -q |grep 'eDP-1 connected') ]]; then
    polybar -r laptop 2>&1 | tee -a /tmp/polybar.log & disown
fi

if [[ $(xrandr -q |grep 'HDMI-1 connected') ]]; then
    polybar -r desktop 2>&1 | tee -a /tmp/polybar.log & disown
fi

if [[ $(xrandr -q |grep 'DP-1 connected') ]]; then
    polybar -r only 2>&1 | tee -a /tmp/polybar.log & disown
fi

# if [[ $(xrandr -q |grep 'DP-1 connected') ]]; then
#     polybar -r desktop 2>&1 | tee -a /tmp/polybar.log & disown
# fi

echo "Polybar launched..."
