set -gx MOZ_ENABLE_WAYLAND 1

# GUI toolkits
set -gx GDK_BACKEND wayland

set -gx QT_QPA_PLATFORM wayland

set -gx CLUTTER_BACKEND wayland

set -gx SDL_VIDEODRIVER wayland

set -gx ECORE_EVAS_ENGINE wayland_egl
set -gx ELM_DISPLAY wl
set -gx ELM_ACCEL gl

set -gx WLR_SESSION direct
