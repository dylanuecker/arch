#!/bin/bash

git_refresh () {
	if [[ 'git rev-list --count origin..HEAD' ]]; then
		git stash
		git pull --no-ff
		git push
		git stash pop
	fi
}

if [[ "$HOSTNAME" == "cloudbreak" ]]; then
	filename=laptop-pkglist
else
	filename=pc-pkglist
fi

cd /home/dylan/arch/pacman

pacman -Qqe > $filename
if [[ 'git status --porcelain $filename' ]]; then
	git add $filename
	git commit -m "Update $filename"
fi

git_refresh
#cd ../../dotfiles
#git_refresh
