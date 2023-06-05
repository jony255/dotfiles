#!/bin/sh

conditionally_start_pipewire() {
    if ! pgrep pipwire; then
        pipewire &
        wireplumber &
        pipewire-pulse &
    fi
}

conditionally_start_pipewire
