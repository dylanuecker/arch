#!/bin/bash

reset=$(tput sgr0)
red=$(tput setaf 1)

pacman -Syu \
	git \
	gvim \
	man-db \
	man-pages \
	pacman-contrib \
	polkit \
	reflector
	sudo \
	textinfo \
	ufw \
	which \
	zsh \

echo -e "runtime defaults.vim\ninoremap jk <ESC>l" > /root/.vimrc

systemctl enable --now ufw.service
ufw default deny
ufw enable

systemctl enable --now paccache.timer
systemctl enable --now pacman-filesdb-refresh.timer

echo "--country US" >> /etc/xdg/reflector/reflector.conf
systemctl enable --now reflector.timer

systemctl enable --now fstrim.timer

systemctl enable --now systemd-timesyncd.service
timedatectl set-ntp true 

useradd -m -G wheel -s /usr/bin/zsh dylan
passwd dylan

echo -e "\n${red}Remember to edit:"
echo      "-->/etc/pacman.conf"
# ILoveCandy
# Color
# VerbosePkgLists
# ParallelDownloads = 5
echo      "-->sudoers file"
# EDITOR=vim visudo
# Add these lines:
# 	Defaults insults
#   <uncomment line about wheel group>
echo -n "${reset}"
