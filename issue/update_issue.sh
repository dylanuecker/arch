#!/bin/bash

# using a systemd unit to generate a new fortune message at boot
# default /etc/issue gets displayed first

# you'll thank yourself in the future
mkdir -p /etc/issue.d

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

\e{lightgreen}This too shall pass.\e{reset}

$(printf "%0.s-" $(seq $max_line_len))
" > /etc/issue.d/fortune.issue

echo -ne \
'
       \e[1;36m.
      \e[1;36m/#\
     \e[1;36m/###\      \e[1;37m               #     \e[1;36m| *
    \e[1;36m/p^###\     \e[1;37m a##e #%" a#"e 6##%  \e[1;36m| | |-^-. |   | \ /
   \e[1;36m/##P^q##\    \e[1;37m.oOo# #   #    #  #  \e[1;36m| | |   | |   |  X
  \e[1;36m/##(   )##\   \e[1;37m%OoO# #   %#e" #  #  \e[1;36m| | |   | ^._.| / \ \e[0;37mTM
 \e[1;36m/###P   q#,^\
\e[1;36m/P^         ^q\ \e[0;37mTM


' >> /etc/issue.d/fortune.issue
