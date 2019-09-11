#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

#exit 0

/etc/init.d/ssh start
/etc/init.d/php7.0-fpm start
/etc/init.d/nginx start


exit 0