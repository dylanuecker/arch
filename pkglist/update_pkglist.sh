#!/bin/bash

if [[ "$HOSTNAME" == "cloudbreak" ]]; then
	filename=laptop-pkglist
else
	filename=pc-pkglist
fi

cd /home/dylan/pkglist/.arch
pacman -Qqe > $filename
if [[ 'git status --porcelain $filename' ]]; then
	git add $filename
	git commit -m "Update package list"
	git push
fi
