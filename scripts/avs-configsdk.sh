#!/usr/bin/env bash

# Setup paths
SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source $SCRIPTS_DIR/avs-config.sh

source $SCRIPTS_DIR/avs-userinput.sh

cd $SDK_BUILD
cmake $SDK_SRC \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
  -DSENSORY_KEY_WORD_DETECTOR=ON \
  -DSENSORY_KEY_WORD_DETECTOR_LIB_PATH=$THIRD_PARTY/alexa-rpi/lib/libsnsr.a \
  -DSENSORY_KEY_WORD_DETECTOR_INCLUDE_DIR=$THIRD_PARTY/alexa-rpi/include \
  -DGSTREAMER_MEDIA_PLAYER=ON \
  -DPORTAUDIO=ON \
  -DPORTAUDIO_LIB_PATH=$THIRD_PARTY/portaudio/lib/.libs/libportaudio.a \
  -DPORTAUDIO_INCLUDE_DIR=$THIRD_PARTY/portaudio/include

if [ -e $SCRIPTS_DIR/AlexaClientSDKConfig.json ]; then
    # If you have a cached copy, then use that
    cp $SCRIPTS_DIR/AlexaClientSDKConfig.json $HOME/BUILD/Integration/AlexaClientSDKConfig.json
else
    # Else substitute the values and cache this copy
    envsubst < $SDK_SRC/Integration/AlexaClientSDKConfig.json > $SDK_BUILD/Integration/AlexaClientSDKConfig.json
fi
