export MOZ_ENABLE_WAYLAND='1'

# GUI toolkits
export GDK_BACKEND='wayland'

export QT_QPA_PLATFORM='wayland'

export CLUTTER_BACKEND='wayland'

export SDL_VIDEODRIVER='wayland'

export ECORE_EVAS_ENGINE='wayland_egl'
export ELM_DISPLAY='wl'
export ELM_ACCEL='gl'

export WLR_SESSION='direct'
