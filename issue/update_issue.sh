#!/bin/bash

# using a systemd unit to generate a new fortune message at boot
# default /etc/issue gets displayed first

mkdir -p /etc/issue.d # you'll thank yourself in the future

fortune=$(fortune -a)

max_line_len=0
while IFS= read -d $'\n' line; do
	no_tabs=$(expand <<< $line)
	curr_line_len=${#no_tabs}
	if ((curr_line_len > max_line_len)); then
		max_line_len=$curr_line_len
	fi
done <<< $fortune

echo -n \
"$(date)

\e{lightred}$fortune\e{reset}

$(printf "%0.s-" $(seq $max_line_len))

\e{lightblue}this too shall pass\nwon't be the last\e{reset}

" > /etc/issue.d/fortune.issue
