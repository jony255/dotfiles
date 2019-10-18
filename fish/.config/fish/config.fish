#!/usr/bin/env fish

function main
    set LOGIN_DIR "$HOME/.login_d_fish"

    if status is-login
        for login_d_script in (find -L $LOGIN_DIR -name '*.fish' -type f)
            source $login_d_script
        end

        if [ (tty) = "/dev/tty1" ]
            exec dbus-launch sway
        end

    end
end

main 
