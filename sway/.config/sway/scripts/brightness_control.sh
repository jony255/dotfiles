#!/bin/sh

brightness_control() {
    brightness_direction=$1
    brightness_delta=$2

    BRIGHTNESS_CMD='light'
    BRIGHTNESS_FLAGS_RAISE='-A'
    BRIGHTNESS_FLAGS_LOWER='-U'

    if [ "$brightness_direction" = 'raise' ]; then
        $BRIGHTNESS_CMD $BRIGHTNESS_FLAGS_RAISE $brightness_delta
    elif [ "$brightness_direction" = 'lower' ]; then
        $BRIGHTNESS_CMD $BRIGHTNESS_FLAGS_LOWER $brightness_delta
    fi
}

brightness_control $@
