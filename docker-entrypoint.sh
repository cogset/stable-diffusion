#!/bin/bash
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- python scripts/txt2img.py "$@"
fi

conda activate aigc

exec "$@"