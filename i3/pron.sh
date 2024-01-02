#!/bin/sh

rm ~/.config/i3/pron
echo "$(du -h ~/dev/ | tail -n1 | awk {'print $1'})" >> ~/.config/i3/pron
