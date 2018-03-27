#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd . > /dev/null
cd $SCRIPT_DIR

git clone git://github.com/xmos/vocalfusion-rpi-setup.git
git clone git://github.com/xmos/avs-sdk-setup.git

RPI_SETUP_DIR=$SCRIPT_DIR/vocalfusion-rpi-setup
AVS_SETUP_DIR=$SCRIPT_DIR/avs-sdk-setup

# Execute (rather than source) the setup scripts
$RPI_SETUP_DIR/setup.sh

echo "Installing Amazon AVS SDK..."

$AVS_SETUP_DIR/setup.sh

echo "Type 'sudo reboot' below to reboot the Raspberry Pi and complete the audio setup."

popd > /dev/null
