#!/usr/bin/env bash

export SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
SENSORY_MODEL_HASH_1=a8befe708af1aa80c32bce5219312a4ec439a0b0
SENSORY_MODEL_HASH_2=ddbc9040e24ed06aafe402017fa640b86d3520b3
SENSORY_MODEL_HASH_3=43b5cb246cb8422a8f39ae92d3e372dc19b98243
# Select Sensory model to use
export SENSORY_MODEL_HASH=$SENSORY_MODEL_HASH_2

pushd .

# Set environment variables and create folders
if [ -z $SDK_SRC ]; then
	source $SCRIPTS_DIR/avs-init.sh
fi

mkdir -p $SOURCE_FOLDER
mkdir -p $LOCAL_BUILD
mkdir -p $HOME/AVS_SDK
mkdir -p $HOME/BUILD

# Set authentication information
if [ -z $SDK_CONFIG_CLIENT_ID ]; then
	if  [ ! -e $SCRIPTS_DIR/AlexaClientSDKConfig.json ]; then
		source $SCRIPTS_DIR/avs-userinput.sh
	fi
fi

# Clone sensory and complete license
if [ ! -d $SOURCE_FOLDER/alexa-rpi ]; then
	cd $SOURCE_FOLDER
	git clone git://github.com/Sensory/alexa-rpi.git
	cd alexa-rpi
	git reset --hard $SENSORY_MODEL_HASH
fi
if [ -e $SOURCE_FOLDER/alexa-rpi/bin/license.sh ]; then
	bash $SOURCE_FOLDER/alexa-rpi/bin/license.sh
fi

$SCRIPTS_DIR/avs-getdepbin.sh | sed "s/^/[apt-get dependencies] /"
$SCRIPTS_DIR/avs-getdepsrc.sh | sed "s/^/[get sources] /"
$SCRIPTS_DIR/avs-nghttp2.sh | sed "s/^/[nghttp2] /"
$SCRIPTS_DIR/avs-openssl.sh | sed "s/^/[openssl] /"
$SCRIPTS_DIR/avs-curl.sh | sed "s/^/[curl] /"
$SCRIPTS_DIR/avs-gstreamer.sh | sed "s/^/[gstreamer] /"
$SCRIPTS_DIR/avs-gst-plugins-base.sh | sed "s/^/[gst base plugins] /"
$SCRIPTS_DIR/avs-libav.sh | sed "s/^/[libav] /"
$SCRIPTS_DIR/avs-gst-plugins-good.sh | sed "s/^/[gst bad plugins] /"
$SCRIPTS_DIR/avs-gst-plugins-bad.sh | sed "s/^/[gst good plugins] /"
$SCRIPTS_DIR/avs-portaudio.sh | sed "s/^/[portaudio] /"
$SCRIPTS_DIR/avs-sensory.sh | sed "s/^/[sensory] /"

$SCRIPTS_DIR/avs-getsdk.sh | sed "s/^/[sdk download] /"
$SCRIPTS_DIR/avs-configsdk.sh | sed "s/^/[sdk config] /"
$SCRIPTS_DIR/avs-buildsdk.sh | sed "s/^/[sdk build] /"

$SCRIPTS_DIR/avs-pyauth.sh | sed "s/^/[authorisation] /"

popd

echo Available aliases:
echo +++ avsmake
echo +++ avsrun
echo +++ avsunit
echo +++ avsintegration
echo This script has not installed any i2s devices
echo Find and run avs-i2si2c.sh to do this
