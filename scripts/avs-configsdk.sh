#!/usr/bin/env bash
cd ~/BUILD
sudo cmake $SDK_SRC -DSENSORY_KEY_WORD_DETECTOR=ON -DSENSORY_KEY_WORD_DETECTOR_LIB_PATH=$LOCAL_BUILD/lib/libsnsr.a -DSENSORY_KEY_WORD_DETECTOR_INCLUDE_DIR=$LOCAL_BUILD/include -DGSTREAMER_MEDIA_PLAYER=ON -DPORTAUDIO=ON -DPORTAUDIO_LIB_PATH=$LOCAL_BUILD/lib/libportaudio.a -DPORTAUDIO_INCLUDE_DIR=$LOCAL_BUILD/include -DCMAKE_PREFIX_PATH=$LOCAL_BUILD -DCMAKE_INSTALL_PREFIX=$LOCAL_BUILD

sudo chown -R $USER $HOME/BUILD
sudo chown -R $USER $LOCAL_BUILD

# If you have a cached copy, then use that
# Else substitute the values and cache this copy
if [ -e $SCRIPTS_DIR/AlexaClientSDKConfig.json ]; then
	rm $HOME/BUILD/Integration/AlexaClientSDKConfig.json
    cp $SCRIPTS_DIR/AlexaClientSDKConfig.json $HOME/BUILD/Integration/
else
	envsubst < $SDK_SRC/Integration/AlexaClientSDKConfig.json > $HOME/BUILD/Integration/
	cp $HOME/BUILD/Integration/AlexaClientSDKConfig.json $SCRIPTS_DIR/
fi
