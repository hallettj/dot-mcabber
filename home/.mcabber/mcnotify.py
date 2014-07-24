#!/usr/bin/python
# Version 0.05
#
#  Copyright (C) 2007 Adam Wolk "Mulander" <netprobe@gmail.com>
#  Slightly updated by Mikael Berthe
#
# To use this script, set the "events_command" option to the path of
# the script (see the mcabberrc.example file for an example)
#
# This script is provided under the terms of the GNU General Public License,
# see the file COPYING in the root mcabber source directory.
#

import sys

#CMD_MSG_IN="/usr/bin/play /home/mulander/sound/machine_move.ogg"
CMD_MSG_IN=""
SHORT_NICK=True

if len(sys.argv) == 5:
	event,arg1,arg2,filename = sys.argv[1:5]
else:
	event,arg1,arg2          = sys.argv[1:4]
	filename                 = None

if event == 'MSG' and arg1 == 'IN':
	import pynotify,os,locale
	encoding  = (locale.getdefaultlocale())[1]
	msg = 'sent you a message.'

	if SHORT_NICK and '@' in arg2:
		arg2 = arg2[0:arg2.index('@')]

	if filename is not None and os.path.exists(filename):
		f   = file(filename)
		msg = f.read().strip()
		os.remove(filename)

	if len(msg) < 1:
		exit(1)

	pynotify.init('mcnotify')
	msgbox = pynotify.Notification(unicode(arg2+':', encoding),unicode(msg, encoding))
	msgbox.set_timeout(3000)
	msgbox.set_urgency(pynotify.URGENCY_LOW)
	msgbox.show()
	if (CMD_MSG_IN):
		os.system(CMD_MSG_IN + '> /dev/null 2>&1')

	pynotify.uninit()

	# An exit status of 2 signals mcabber to produce a beep.
	exit(2)

# vim:set noet sts=8 sw=8:
