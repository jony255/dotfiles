#!/usr/bin/env fish

if [ -z "$XDG_RUNTIME_DIR" ]
    set -gx XDG_RUNTIME_DIR /tmp/$USER-runtime-dir
    
    if [ test -d "$XDG_RUNTIME_DIR" ]
        mkdir "$XDG_RUNTIME_DIR"
        chmod 0700 "$XDG_RUNTIME_DIR"
    end
end

