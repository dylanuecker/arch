#!/bin/sh

dir="~/arch"
cd dir

sudo ln -s $dir/pacman/pacman.conf /etc/pacman.conf

sudo ln -s $dir/issue/update-issue.service /etc/systemd/system/update-issue.service
sudo systemctl enable update-issue.service

systemctl --user link pacman/archdots.service
systemctl --user link pacman/archdots.timer
systemctl --user enable archdots.timer

ln -s $dir/fonts/* ~/.local/share/fonts/
sudo pacman -S ttf-jetbrains-mono ttf-nerd-fonts-symbols-mono

ln -s $dir/backgrounds/* ~/.local/share/backgrounds/

if [[ "$HOSTNAME" == "cloudbreak" ]]; then
	ln -s $dir/bin/laptop/* ~/.local/bin/
fi
