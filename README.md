# arch linux

Important system maintenance:
    - check orphaned packages
    - remove unused config files
    - journalctl
    - check systemd services
    - clean cache
    - fix boot errors
    - fix system upgrade errors (missing firmware)

Slow app startup times on laptop -- apps tried loading nvidia driver first, reorder
/usr/share/glvnd/egl_vendor.d/ so that mesa file is first (lower) than nvidia

Using nvidia drivers with PRIME for hybrid graphics on laptop, use the two scripts in laptop/
to enable and disable the GTX 1050 ti mobile.
