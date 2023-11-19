#!/bin/sh

sudo ln -sr pacman/pacman.conf /etc/pacman.conf

sudo ln -sr issue/update-issue.service /etc/systemd/system/update-issue.service
sudo systemctl enable update-issue.service

systemctl --user link pacman/archdots.service
systemctl --user link pacman/archdots.timer
systemctl --user enable archdots.timer

ln -sr fonts/* ~/.local/share/fonts/
sudo pacman -S ttf-jetbrains-mono ttf-nerd-fonts-symbols-mono

ln -sr backgrounds/* ~/.local/share/backgrounds/

if [[ "$HOSTNAME" == "cloudbreak" ]]; then
	ln -sr bin/laptop/* ~/.local/bin/
fi
