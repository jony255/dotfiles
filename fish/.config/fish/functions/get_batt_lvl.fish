function get_batt_lvl
    cat /sys/class/power_supply/BAT0/capacity
end

