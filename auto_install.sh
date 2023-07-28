#!/usr/bin/env bash
# Copyright 2021 XMOS LIMITED. This software is subject to the terms of the
# XMOS Public Licence, Version 1
pushd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null
SETUP_DIR="$( pwd )"
RPI_SETUP_REPO=vocalfusion-rpi-setup
RPI_SETUP_DIR=$SETUP_DIR/$RPI_SETUP_REPO
RPI_SETUP_SCRIPT=$RPI_SETUP_DIR/setup.sh

RPI_SETUP_TAG="v5.8.0"
AVS_DEVICE_SDK_TAG="v3.0.0.0"
AVS_SCRIPT="setup.sh"

# Valid values for XMOS device
VALID_XMOS_DEVICES="xvf3100 xvf3500 xvf3510-int xvf3510-ua xvf3600-slave xvf3600-master xvf3610-int xvf3610-ua xvf3615-int xvf3615-ua"
VALID_KEY_WORD_DETECTOR="G H"

XMOS_DEVICE=

# Default device serial number if nothing is specified
DEVICE_SERIAL_NUMBER="123456"
# Disable any keyword detector by default
KEY_WORD_DETECTOR_FLAG=""
usage() {
  local VALID_XMOS_DEVICES_DISPLAY_STRING=
  local NUMBER_OF_VALID_DEVICES=$(echo $VALID_XMOS_DEVICES | wc -w)
  local i=1
  local SEP=
  # Build a string of valid device options
  for d in $VALID_XMOS_DEVICES; do
    if [[ $i -eq $NUMBER_OF_VALID_DEVICES ]]; then
      SEP=" or "
    fi
    VALID_XMOS_DEVICES_DISPLAY_STRING=$VALID_XMOS_DEVICES_DISPLAY_STRING$SEP$d
    SEP=", "
    (( ++i ))
  done

  cat <<EOT
usage: auto_install.sh <DEVICE-TYPE> [OPTIONS]

A JSON config file, config.json, must be present in the current working
directory. The config.json can be downloaded from developer portal and must
contain the following:
   "clientId": "<Auth client ID>"
   "productId": "<your product name for device>"

The DEVICE-TYPE is the XMOS device to setup: $VALID_XMOS_DEVICES_DISPLAY_STRING

Optional parameters:
  -s <serial-number>  If nothing is provided, the default device serial number
                      is 123456
  -w <keyword-detector-type> Keyword detector to setup: possible values are G (GPIO trigger), H (HID trigger),  default is no keyword detector, only tap-to-talk is enabled'
  -h                  Display this help and exit
EOT
}

CONFIG_JSON_FILE="config.json"
if [ ! -f "$CONFIG_JSON_FILE" ]; then
    echo "error: config JSON file not found."
    echo
    usage
    exit 1
fi

if [ $# -lt 1 ] || [ $1 == '-h' ]; then
    usage
    exit 1
fi

XMOS_DEVICE=$1
shift 1

OPTIONS=s:w:h
while getopts "$OPTIONS" opt ; do
    case $opt in
        s )
            DEVICE_SERIAL_NUMBER="$OPTARG"
            ;;
        w )
            KEY_WORD_DETECTOR_FLAG="-w $OPTARG"
            ;;
        h )
            usage
            exit 1
            ;;
    esac
done

# validate XMOS_DEVICE value
validate_device() {
  local DEV=$1
  shift
  for d in $*; do
    if [[ "$DEV" = "$d" ]]; then
      return 0
    fi
  done
  return 1
}
if ! validate_device $XMOS_DEVICE $VALID_XMOS_DEVICES; then
  echo "error: $XMOS_DEVICE is not a valid device type."
  echo
  usage
  exit 1
fi

# validate keyword detector value
validate_kwd() {
  local KWD=$1
  shift
  for d in $*; do
    if [[ "$KWD" = "$d" ]]; then
      return 0
    fi
  done
  return 1
}
# Extract key word detector type
KEY_WORD_DETECTOR=${KEY_WORD_DETECTOR_FLAG#"-w "}
if [ -n "$KEY_WORD_DETECTOR_FLAG" ] && ! validate_kwd $KEY_WORD_DETECTOR $VALID_KEY_WORD_DETECTOR; then
  echo "error: $KEY_WORD_DETECTOR is not a valid keyword detector."
  echo
  usage
  exit 1
fi

# Exit if chromium browser is open
if pgrep chromium > /dev/null ; then
  echo "Error: Chromium browser is open"
  echo "Please close the browser and restart the installation procedure"
  exit 2
fi

# Amazon have changed the SDK directory structure. Prior versions will need to delete the directory before updating.
SDK_DIR=$HOME/sdk-folder
if [ -d $SDK_DIR ]; then
  echo "Delete $SDK_DIR directory"
  rm -rf $SDK_DIR
fi

mkdir $SDK_DIR

if [ -d $RPI_SETUP_DIR ]; then
  echo "Delete $RPI_SETUP_DIR directory"	
  rm -rf $RPI_SETUP_DIR
fi

git clone -b $RPI_SETUP_TAG https://github.com/xmos/$RPI_SETUP_REPO.git

# Convert xvf3615 device into xvf3610 device and '-g' argument
if [[ "$XMOS_DEVICE" == "xvf3615-int" ]]; then
  XMOS_DEVICE="xvf3610-int"
  if [ -z $KEY_WORD_DETECTOR_FLAG ]; then
    KEY_WORD_DETECTOR_FLAG="-w G"
  fi
fi
if [[ "$XMOS_DEVICE" == "xvf3615-ua" ]]; then
  XMOS_DEVICE="xvf3610-ua"
  if [ -z $KEY_WORD_DETECTOR_FLAG ]; then
    KEY_WORD_DETECTOR_FLAG="-w H"
  fi
fi

# Execute (rather than source) the setup scripts
echo "Installing VocalFusion ${XMOS_DEVICE:3} Raspberry Pi Setup..."
if $RPI_SETUP_SCRIPT $XMOS_DEVICE; then

  # The line below is needed to avoid the error:
  # E: Repository 'http://raspbian.raspberrypi.org/raspbian buster InRelease' changed its 'Suite' value from 'testing' to 'stable'
  # N: This must be accepted explicitly before updates for this repository can be applied. See apt-secure(8) manpage for details.
  sudo apt update --allow-releaseinfo-change
  echo "Installing Amazon AVS SDK..."
  wget -O $AVS_SCRIPT https://raw.githubusercontent.com/xmos/avs-device-sdk/$AVS_DEVICE_SDK_TAG/tools/Install/$AVS_SCRIPT
  wget -O pi.sh https://raw.githubusercontent.com/xmos/avs-device-sdk/$AVS_DEVICE_SDK_TAG/tools/Install/pi.sh
  wget -O genConfig.sh https://raw.githubusercontent.com/xmos/avs-device-sdk/$AVS_DEVICE_SDK_TAG/tools/Install/genConfig.sh
  chmod +x $AVS_SCRIPT
  AVS_CMD="./${AVS_SCRIPT} ${CONFIG_JSON_FILE} ${AVS_DEVICE_SDK_TAG} -s ${DEVICE_SERIAL_NUMBER} -x ${XMOS_DEVICE} ${KEY_WORD_DETECTOR_FLAG}"
  echo "Running command ${AVS_CMD}"
  if $AVS_CMD; then
    echo "Type 'sudo reboot' below to reboot the Raspberry Pi and complete the AVS setup."
  fi
fi

popd > /dev/null
