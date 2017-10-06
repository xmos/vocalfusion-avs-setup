#!/usr/bin/env bash

# Setup paths
SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source $SCRIPTS_DIR/avs-config.sh

cd $THIRD_PARTY
wget -c http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz
tar zxf pa_stable_v190600_20161030.tgz
