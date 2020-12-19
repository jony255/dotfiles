#!/bin/sh

# TODO: Implement error checking for inputs.

brightness_control() {
    BRIGHTNESS_DIRECTION="$1"
    BRIGHTNESS_DELTA="$2"

    BRIGHTNESS_CMD='light'
    BRIGHTNESS_FLAGS_RAISE='-A'
    BRIGHTNESS_FLAGS_LOWER='-U'

    if [ "$BRIGHTNESS_DIRECTION" = 'raise' ]; then
        $BRIGHTNESS_CMD $BRIGHTNESS_FLAGS_RAISE $BRIGHTNESS_DELTA
    elif [ "$BRIGHTNESS_DIRECTION" = 'lower' ]; then
        $BRIGHTNESS_CMD $BRIGHTNESS_FLAGS_LOWER $BRIGHTNESS_DELTA
    fi
}

brightness_control $@
