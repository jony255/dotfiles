#!/bin/sh

conditionally_start_pipewire() {
    if ! pgrep pipwire; then
        exec pipewire
    fi
}

conditionally_start_pipewire
