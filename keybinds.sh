#!/bin/bash


test=$(wmctrl -m | grep Name | awk '{print $2}')
if [ $test = wlroots ]
then
  grep 'bindsym\|mode' .config/sway/config | grep -v 'bindsym $mod+[0-9]\|bindsym $mod+Shift+[0-9]\|#\|Left\|Right\|Down\|Up\|splith\|splitv\|resize\|default' | awk '!/^(bindsym $mod+:digit: | bindsym $mod+Shift+:digit:)/{ gsub(/--no-startup-id/,""); gsub(/--locked/,""); gsub(/$mod/,"Super"); gsub(/XF86/,"");gsub(/pactl/, "");  $1=$3=""; print $2,$4 }' | sed -r "s/^\s+//g"
elif [ $test = i3 ]
then
  grep 'bindsym' .config/i3/config | grep -v 'bindsym $mod+[0-9]\|bindsym $mod+Shift+[0-9]\|#\|Left\    |Right\|Down\|Up\|splith\|splitv\|resize\|default' | awk '!/^(bindsym $mod+:digit: | bindsym $mod+Shif    t+:digit:)/{ gsub(/--no-startup-id/,""); gsub(/--locked/,""); gsub(/$mod/,"Super"); gsub(/XF86/,"");gs    ub(/pactl/, "");  $1=$3=""; print $2,$4 }' | sed -r "s/^\s+//g"
fi

