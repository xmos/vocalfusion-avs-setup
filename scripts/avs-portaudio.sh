#!/usr/bin/env bash

# Setup paths
SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" 
source $SCRIPTS_DIR/avs-config.sh

cd $THIRD_PARTY/*portaudio*/
./configure --without-jack
make -j3
