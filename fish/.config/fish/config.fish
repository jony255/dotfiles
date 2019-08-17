#!/usr/bin/env fish

function main
    if status is-login
        for login_d_script in (find -L "$HOME/.login_d_fish" -name '*.fish' -type f)
            source $login_d_script
        end

        exec dbus-launch sway
    end
end

main 
