#!/bin/sh

# strip off media_dir's force_sort strings
# when this is the original version of minidlna
if [ -n "$(head -n1 /CHANGES | grep -E 'original$')" ]; then
  sed -ri 's/^(media_dir=[AVP]+,[^,]+).*/\1/p' /conf/minidlna.conf
fi

# allow RW on all created files
umask 0000

# remove pid file to ensure daemon can be started
rm -f /var/run/minidlna/minidlna.pid

exec /usr/local/sbin/minidlnad "$@"
