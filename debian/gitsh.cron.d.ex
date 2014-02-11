#
# Regular cron jobs for the gitsh package
#
0 4	* * *	root	[ -x /usr/bin/gitsh_maintenance ] && /usr/bin/gitsh_maintenance
