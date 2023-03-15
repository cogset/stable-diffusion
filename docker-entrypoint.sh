#!/bin/bash
set -e

conda activate aigc

exec "$@" $FC_CUSTOM_CONTAINER_EVENT