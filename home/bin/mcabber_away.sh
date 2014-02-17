#!/bin/bash
#
# Sets mcabber status to "away" when xscreensaver is activated; returns
# status to "online" when xscreensaver is deactivated.

MCABBER_DIR=~/.mcabber
WEECHAT_DIR=~/.weechat
AWAY_MESSAGE="I'm not at my keyboard right now."

send_command() {
	local dir="$1"
	local cmd="$2"
	for file in "$dir"/*; do
		if [ -p "$file" ]; then
			echo "$cmd" > "$file"
		fi
	done
}

set_away() {
	send_command "$MCABBER_DIR" "status away $AWAY_MESSAGE"
	send_command "$WEECHAT_DIR" "*/away $AWAY_MESSAGE"
}

set_online() {
	send_command "$MCABBER_DIR" "status online -"
	send_command "$WEECHAT_DIR" "*/away"
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
