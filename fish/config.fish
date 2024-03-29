#!/usr/bin/env fish

function main
    set LOGIN_DIR "$HOME/.config/fish/login.d/"

    if status is-login
        for logind_script in (find -L $LOGIN_DIR -name '*.fish' -o -name '*.sh' -type f | sort)
            source $logind_script
        end

        if [ (tty) = "/dev/tty1" ]
            exec dbus-launch sway
        end
    end
end

main
