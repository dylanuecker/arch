#!/bin/bash

if [[ "$HOSTNAME" == "cloudbreak" ]]; then
	filename=laptop-pkglist
else
	filename=pc-pkglist
fi

git_refresh () {
	if [[ 'git rev-list --count origin..HEAD' ]]; then
		git stash
		git pull --no-ff
		git push
		git stash pop
	fi
}

cd /home/dylan/arch/pacman

# on a timer
if [[ $1 == "timer" ]]; then
	pacman -Qqe > $filename
	if [[ 'git status --porcelain $filename' ]]; then
		git add $filename
		git commit -m "Update package list"
	fi
elif [[ $1 == "hook"]]; then
	git_refresh
	cd ../../dotfiles
	git_refresh
fi
