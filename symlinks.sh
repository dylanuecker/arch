#!/bin/sh

ln -sr pkglist/package_list.hook /etc/pacman.d/hooks/package_list.hook

ln -sr issue/update-issue.service /etc/systemd/system/update-issue.service
systemctl enable update-issue.service

ln -sr fonts ~/.local/share/fonts

ln -sr wallpaper ~/.config/wallpaper
