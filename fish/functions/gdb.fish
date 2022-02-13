function gdb --description 'alias gdb=gdb -q -nh -x $XDG_CONFIG_HOME/gdb/gdbinit'
 command gdb -q -nh -x "$XDG_CONFIG_HOME"/gdb/gdbinit $argv;
end
