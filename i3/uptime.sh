#!/bin/sh

rm ~/.config/i3/uptime
echo "$(uptime -p | sed s/"up"/"Up for:"/ | sed s/" hour, "/h/ | sed s/" minutes"/m/)" >> ~/.config/i3/uptime
