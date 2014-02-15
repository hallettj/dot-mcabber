set jid = yourname@example.com

set tls = 1
set ssl_ignore_checks = 0

set logging_dir = ~/.mcabber/histo/yourname@example.com
set statefile = ~/.mcabber/example.state
set fifo_name = ~/.mcabber/fifo_example

source ~/.mcabber/mcabberrc
