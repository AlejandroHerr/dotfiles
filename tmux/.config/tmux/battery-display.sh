#!/usr/bin/env bash
BATT_SCRIPTS="$HOME/.config/tmux/plugins/tmux-battery/scripts"
FOAM='#9ccfd8'; GOLD='#f6c177'; LOVE='#eb6f92'; PINE='#31748f'

percentage=$("$BATT_SCRIPTS/battery_percentage.sh" 2>/dev/null)

if [ -z "$percentage" ]; then
    printf "#[fg=$PINE]󱘖#[default]"
    exit 0
fi

batt_status=$(pmset -g batt 2>/dev/null | awk -F '; *' 'NR==2 { print $2 }')

if [[ "$batt_status" == "charging" || "$batt_status" == "charged" || "$batt_status" == "full" || "$batt_status" == "AC attached" ]]; then
    printf "#[fg=$PINE]%s 󱘖#[default]" "$percentage"
    exit 0
fi

pct="${percentage//%/}"
if   [ "$pct" -ge 65 ]; then color=$FOAM
elif [ "$pct" -ge 20 ]; then color=$GOLD
else                          color=$LOVE
fi

if   [ "$pct" -ge 95 ]; then charge_icon='󰁹'
elif [ "$pct" -ge 80 ]; then charge_icon='󰂁'
elif [ "$pct" -ge 65 ]; then charge_icon='󰂀'
elif [ "$pct" -ge 50 ]; then charge_icon='󰁾'
elif [ "$pct" -ge 35 ]; then charge_icon='󰁽'
elif [ "$pct" -ge 20 ]; then charge_icon='󰁼'
elif [ "$pct" -gt  5 ]; then charge_icon='󰁻'
else                          charge_icon='󰁺'
fi

printf "#[fg=$color]%s %s#[default]" "$percentage" "$charge_icon"
