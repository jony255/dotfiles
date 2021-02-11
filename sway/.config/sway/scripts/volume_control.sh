#!/bin/sh

# TODO: Implement error checking for inputs.

volume_control() {
    VOLUME_DIRECTION="$1"
    VOLUME_DELTA="$2"

    VOLUME_CMD='amixer'
    VOLUME_FLAGS='set Master'

    if [ "$VOLUME_DIRECTION" = "raise" ]; then
        $VOLUME_CMD $VOLUME_FLAGS ${VOLUME_DELTA}%+
    elif [ "$VOLUME_DIRECTION" = "lower" ]; then
        $VOLUME_CMD $VOLUME_FLAGS ${VOLUME_DELTA}%-
    elif [ "$VOLUME_DIRECTION" = "toggle" ]; then
        $VOLUME_CMD $VOLUME_FLAGS toggle
    fi
}

volume_control "$@"
