#
# Regular cron jobs for the xdg-storage package
#

# maintenance
0 4	* * *	root	[ -x /usr/bin/xdg-storage_maintenance ] && /usr/bin/xdg-storage_maintenance

