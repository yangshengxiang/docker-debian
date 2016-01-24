#!/usr/bin/env sh
set -e

INIT_SCRIPT=/srv/www/init.sh

# if exists initial script, execute it
if [ -f "$INIT_SCRIPT" ]; then
	chmod +x $INIT_SCRIPT
	exec sh $INIT_SCRIPT;
fi

exec "$@"