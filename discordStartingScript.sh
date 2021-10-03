#!/bin/sh

i3-msg -t command "exec discord"

sleep 10

i3-msg -t command "[class = "discord"] focus , split vertical"

i3-msg -t command "exec discord-canary"
