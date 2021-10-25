#!/bin/sh

kitty

kitty -T gtop gtop
swaymsg -t command "[title="gtop"] focus, split vertical"
kitty htop
