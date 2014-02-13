#!/bin/bash
#
# Sets mcabber status to "away" when xscreensaver is activated; returns
# status to "online" when xscreensaver is deactivated.

MCABBER_DIR=~/.mcabber
AWAY_MESSAGE="I'm not at my keyboard right now."

send_command() {
	local cmd="$1"
	for file in "$MCABBER_DIR"/*; do
		if [ -p "$file" ]; then
			echo "$cmd" > "$file"
		fi
	done
}

set_away() {
	send_command "status away $AWAY_MESSAGE"
}

set_online() {
	send_command "status online -"
}

process() {
	while read line; do
		case "$line" in
			UNBLANK*)
				set_online
				;;
			BLANK* | LOCK*)
				set_away
				;;
			RUN*)
				;;
		esac
	done
}

xscreensaver-command -watch | process
