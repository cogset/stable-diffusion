#!/bin/bash
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- python launch.py "$@"
fi

COMMANDLINE_ARGS="--listen --api --nowebui"

exec "$@"