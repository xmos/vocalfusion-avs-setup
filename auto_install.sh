#!/usr/bin/env bash
pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
SETUP_DIR="$( pwd )"
RPI_SETUP_DIR=$SETUP_DIR/vocalfusion-rpi-setup
AVS_SETUP_DIR=$SETUP_DIR/avs-sdk-setup

RPI_SETUP_TAG="v1.1"
AVS_SETUP_TAG="v1.5"

if [ ! -d $RPI_SETUP_DIR ]; then
  git clone -b $RPI_SETUP_TAG git://github.com/xmos/vocalfusion-rpi-setup.git
else
  if ! git -C $RPI_SETUP_DIR diff-index --quiet HEAD -- ; then
    echo "Changes found in $RPI_SETUP_DIR. Please revert changes, or delete directory, and then rerun."
    echo "Exiting install script."
    popd > /dev/null
    return
  fi

  echo "Updating VocalFusion Raspberry Pi Setup"
  git -C $RPI_SETUP_DIR fetch > /dev/null
  git -C $RPI_SETUP_DIR checkout $RPI_SETUP_TAG > /dev/null

fi

if [ ! -d $AVS_SETUP_DIR ]; then
  git clone -b $AVS_SETUP_TAG git://github.com/xmos/avs-sdk-setup.git
else
  if ! git -C $AVS_SETUP_DIR diff-index --quiet HEAD -- ; then
    echo "Changes found in $AVS_SETUP_DIR. Please revert changes, or delete directory, and then rerun."
    echo "Exiting install script."
    popd > /dev/null
    return
  fi

  echo "Updating Amazon AVS SDK"
  git -C $AVS_SETUP_DIR fetch > /dev/null
  git -C $AVS_SETUP_DIR checkout $AVS_SETUP_TAG > /dev/null

fi

# Execute (rather than source) the setup scripts
echo "Installing VocalFusion Raspberry Pi Setup..."
$RPI_SETUP_DIR/setup.sh

echo "Installing Amazon AVS SDK..."
$AVS_SETUP_DIR/setup.sh

echo "Type 'sudo reboot' below to reboot the Raspberry Pi and complete the audio setup."

popd > /dev/null
