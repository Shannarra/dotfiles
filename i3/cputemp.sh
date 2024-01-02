
#!/bin/sh

rm ~/.config/i3/cputemp

echo "$(cat /sys/class/thermal/thermal_zone*/temp | sort -n  | tail -n1 | sed -e "s/\b[0-9][0-9]/&./")" >> ~/.config/i3/cputemp
