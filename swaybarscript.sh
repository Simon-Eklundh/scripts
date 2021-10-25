# Change this according to your device
################
# Variables
################

# Keyboard input name
keyboard_input_name="0:0:X11_keyboard"

# Date and time
date_and_week=$(date "+%Y-%m/%d (w%-V)")
current_time=$(date "+%H:%M")

#############
# Commands
#############

# Battery or charger
battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage"| awk '{print $1,$2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')

# Audio and multimedia
media_artist=$(playerctl metadata artist)
media_song=$(playerctl metadata title)
player_status=$(playerctl status)

# Network
network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')

ping=$(ping -c 1 www.google.es | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)

# Others
language=$(swaymsg -r -t get_inputs | awk '/0:0:X11_keyboard/;/xkb_active_layout_name/' | grep -A1 '\b0:0:X11_keyboard\b' | grep "xkb_active_layout_name" | awk -F '"' '{print $4}')
loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')

# Removed weather because we are requesting it too many times to have a proper
# refresh on the bar
#weather=$(curl -Ss 'https://wttr.in/Stockholm?0&T&Q&format=1')

## Currently focused window
Focused_Window=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true).name')
#CurrentSong=$(swaymsg -t get_tree | jq '.. | select(.type?) | .window_properties | select(.instance=="spotify").title')
CurrentSong=$(playerctl metadata -f '{{xesam:artist}} - {{xesam:title}}')

if [ $battery_status = "discharging" ]
then
    battery_pluggedin='⚠'
else
    battery_pluggedin='⚡'
fi

if ! [ $network ]
then
   network_active="No network active"
else
   network_active="⇆"
fi

if [ $player_status = "Playing" ]
then
    song_status='▶'
elif [ $player_status = "Paused" ]
then
    song_status='⏸'
else
    song_status='⏹'

fi

# 🎧 $song_status $media_artist - $media_song
echo " $Focused_Window | 🎧 $CurrentSong $song_status | ⌨ $language | $network_active ($ping ms) | loadavg $loadavg_5min | $battery_pluggedin $battery_charge | $date_and_week 🕘 $current_time"
