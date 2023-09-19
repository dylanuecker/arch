# arch linux

Important system maintenance:
- 'pacman -Syu' for system update and upgrade
- cleaning pacman cache and update mirror list automatically done weekly
- journalctl

Finally using nvidia drivers with PRIME for hybrid graphics. Use the two scripts
in here to enable and disable the GTX 1050 ti mobile.

Slow app startup times on laptop -- apps tried loading nvidia driver first, reorder
/usr/share/glvnd/egl_vendor.d/ so that mesa file is first (lower) than nvidia
