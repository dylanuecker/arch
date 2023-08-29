#!/bin/bash

# TODO
# - use stack property to keep track of last indices when moving up and down
#   between directory levels, can "return" to previously selected dirs this
#   way, won't be very hard
# - try to update PS1 in some way on each cd
# - what if number of directories carries over onto more than one line
# - display git pull message only if remote is ahead, to be effective need to
#   be using a keyring, so I won't have to unlock the key each time

cleanup() {
	tput el
	tput cnorm
	if [ $toggle = 1 ]; then
		shopt -u dotglob
	fi
	if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]; then
		gs
		echo -e "\033[31mgit pull?\033[0m\n"
	fi
	ls
}

trap "cleanup && return" SIGINT

index=0
toggle=0
tput civis
while : ; do
	dirs=($(ls -d */ 2> /dev/null | tr -d "/"))
	output=($(ls --color=always -d */ 2> /dev/null | tr -d "/"))
	output[$index]="\033[31;1m${dirs[$index]}\033[0m"
	if [ ${#dirs[@]} == 0 ]; then
		echo -n "no dirs"
	else
		echo -en "${output[*]}"
	fi
	tput el
	echo -en "\r"
	read -s -n 1 input
	case $input in
		h)
			if [ $index != 0 ]; then
				((index--))
			fi
			;;
		j) 
			cd ${dirs[$index]} 
			index=0
			;;
		k)
			cd ..
			index=0
			;;
		l)
			if [ $index != $(( ${#dirs[@]} - 1)) ]; then
				((index++))
			fi
			;;
		a)
			if [ $toggle == 0 ]; then
				shopt -s dotglob
				toggle=1
			else
				shopt -u dotglob
				toggle=0
			fi
			;;
		d)
			cd
			break
			;;
		f)
			cd
			index=0
			;;
		"")
			break
			;;
	esac
done
cleanup
