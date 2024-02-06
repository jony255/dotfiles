#!/bin/sh

FILENAME="$(printf '%s/%s.png' "$(xdg-user-dir PICTURES)" "$(date +%Y_%m_%d-%I_%M_%S%p)")"

grim -c -g "$(slurp)" "$FILENAME"

if [ "$1" = '--copy' ]; then
    wl-copy < "$FILENAME"
fi
