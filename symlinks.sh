#!/bin/sh

sudo ln -sr pacman/pacman.conf /etc/pacman.conf

systemctl --user link pacman/archdots.service
systemctl --user link pacman/archdots.timer
systemctl --user enable archdots.timer

sudo ln -sr issue/update-issue.service /etc/systemd/system/update-issue.service
sudo systemctl enable update-issue.service

ln -sr fonts ~/.local/share/fonts
