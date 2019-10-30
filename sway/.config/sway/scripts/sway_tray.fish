#!/usr/bin/env fish

function sway_tray
    while true
        set date_and_time (date +'%D %r')
        set batt_lvl (get_batt_lvl) 

        echo "$batt_lvl% $date_and_time"

        sleep 1
    end
end

sway_tray
