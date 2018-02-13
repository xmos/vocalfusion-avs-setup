#!/usr/bin/env bash

# Setup paths
SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source $SCRIPTS_DIR/avs-config.sh

cd $THIRD_PARTY
sudo chown -R $USER $SDK_BUILD

mkdir -p $SDK_BUILD/lib
mkdir -p $SDK_BUILD/include
mkdir -p $SDK_BUILD/models

cp alexa-rpi/lib/libsnsr.a $SDK_BUILD/lib
cp alexa-rpi/include/snsr.h $SDK_BUILD/include
cp alexa-rpi/models/spot-alexa-rpi-31000.snsr $SDK_BUILD/models
