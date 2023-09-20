#!/bin/sh
{
	echo -e "$(date)\n"

	if [[ "$HOSTNAME" == "cloudbreak" ]]; then
		filename=laptop-pkglist
	else
		filename=pc-pkglist
	fi

	cd /home/dylan/arch/pacman
	git stash
	git pull --no-ff --no-edit
	pacman -Qqe > $filename
	if [[ -n $(git status --porcelain $filename) ]]; then
		git add $filename
		git commit -m "Update $filename"
	fi
	git push
	git stash pop

	#git rev-list --count origin..HEAD
	#check if there are any local commits

	cd ../../dotfiles
	git stash
	git pull --no-ff --no-edit
	git push
	git stash pop

	echo -e "\n-------------------------------------------------------------------------------\n"
} &>> /home/dylan/arch/pacman/archdots.log
