#!/usr/bin/env fish

function volume_control -a volume_direction volume_delta
    set VOLUME_CMD amixer
    set VOLUME_FLAGS set Master

    if [ "$volume_direction" = "raise" ]
        $VOLUME_CMD $VOLUME_FLAGS $volume_delta%+
    else if [ "$volume_direction" = "lower" ]
        $VOLUME_CMD $VOLUME_FLAGS $volume_delta%-
    else if [ "$volume_direction" = "toggle" ]
        $VOLUME_CMD $VOLUME_FLAGS toggle
    end

end

volume_control $argv
