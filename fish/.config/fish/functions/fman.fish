function fman
    set -lx MANPATH "$__fish_data_dir/man"

    man $argv
end
