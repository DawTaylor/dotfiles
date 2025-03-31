#!/bin/bash


PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

if [ !-z "$PERCENTAGE" ]; then
  sketchybar --add item battery right \
            --set battery update_freq=120 \
                          script="$PLUGIN_DIR/battery.sh" \
            --subscribe battery system_woke power_source_change
fi

