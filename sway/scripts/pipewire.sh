#!/bin/sh

conditionally_start_pipewire() {
    if ! pgrep pipwire; then
        pipewire &
        pipewire-pulse &
    fi
}

conditionally_start_pipewire
