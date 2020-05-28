function man
    command man $argv 1>/dev/null && command man $argv | nvim -c 'set ft=man'
end
