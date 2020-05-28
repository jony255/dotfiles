function fman
    set -lx MANPATH "$__fish_data_dir/man"

    command man $argv 1>/dev/null && command man $argv | nvim -c 'set ft=man'
end
