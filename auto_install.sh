#!/usr/bin/env bash
pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
SETUP_DIR="$( pwd )"
RPI_SETUP_DIR=$SETUP_DIR/vocalfusion-rpi-setup

RPI_SETUP_TAG="v1.2"
AVS_DEVICE_SDK_TAG="xmos_v1.6"
AVS_SCRIPT="setup.sh"

# Amazon have changed the SDK directory structure. Prior versions will need to delete the directory before updating.
SDK_DIR=$HOME/sdk-folder
if [ -d $SDK_DIR ]; then
  if [ -d $SDK_DIR/avs-device-sdk ] && [ $(git -C $SDK_DIR/avs-device-sdk rev-parse --abbrev-ref HEAD) = $AVS_DEVICE_SDK_TAG ]; then
    # SDK build folder is aligned with latest Amazon changes
    :
  else
    echo "Error: $SDK_DIR is out of date. Please delete directory and then rerun."
    echo "Exiting install script."
    popd > /dev/null
    return
  fi
fi

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

# Execute (rather than source) the setup scripts
echo "Installing VocalFusion Raspberry Pi Setup..."
if $RPI_SETUP_DIR/setup.sh vocalfusion ; then

  echo "Installing Amazon AVS SDK..."
  wget -O $AVS_SCRIPT https://raw.githubusercontent.com/xmos/avs-device-sdk/$AVS_DEVICE_SDK_TAG/tools/Install/$AVS_SCRIPT
  chmod +x $AVS_SCRIPT
  if ./$AVS_SCRIPT ; then

    echo "Type 'sudo reboot' below to reboot the Raspberry Pi and complete the AVS setup."
  fi
fi

popd > /dev/null
