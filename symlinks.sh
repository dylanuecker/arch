#!/bin/sh

ln -sr pacman/package_list.hook /etc/pacman.d/hooks/package_list.hook
sudo ln -sr pacman/pacman.conf /etc/pacman.conf

ln -sr issue/update-issue.service /etc/systemd/system/update-issue.service
systemctl enable update-issue.service

ln -sr fonts ~/.local/share/fonts
