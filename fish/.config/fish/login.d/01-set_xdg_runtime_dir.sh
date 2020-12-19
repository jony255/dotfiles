if [ -z "$XDG_RUNTIME_DIR" ]
    export XDG_RUNTIME_DIR="/tmp/$USER-runtime-dir"

    if [ ! -d "$XDG_RUNTIME_DIR" ]
        mkdir -p "$XDG_RUNTIME_DIR"
        chmod 0700 "$XDG_RUNTIME_DIR"
    end
end

