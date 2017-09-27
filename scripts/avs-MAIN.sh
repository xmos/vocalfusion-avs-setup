#!/usr/bin/env bash

export SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

pushd .

# Set environment variables and create folders
if [ -z $SDK_SRC ]; then
	source $SCRIPTS_DIR/avs-init.sh
	mkdir $SOURCE_FOLDER
	mkdir $LOCAL_BUILD
	mkdir $HOME/AVS_SDK
	mkdir $HOME/BUILD
fi

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
fi
if [ -e $SOURCE_FOLDER/alexa-rpi/bin/license.sh ]; then
	echo "Press 'Enter' and complete the license"
	bash $SOURCE_FOLDER/alexa-rpi/bin/license.sh
fi

TIMER=~/time_taken.txt
SECONDS=0
$SCRIPTS_DIR/avs-getdepbin.sh | sed "s/^/[apt-get dependencies] /"
echo "apt-get deps: $SECONDS" > $TIMER
$SCRIPTS_DIR/avs-getdepsrc.sh | sed "s/^/[get sources] /"
echo "getsrc: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-nghttp2.sh | sed "s/^/[nghttp2] /"
echo "nghttp2: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-openssl.sh | sed "s/^/[openssl] /"
echo "openssl: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-curl.sh | sed "s/^/[curl] /"
echo "curl: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-gstreamer.sh | sed "s/^/[gstreamer] /"
echo "gstreamer: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-gst-plugins-base.sh | sed "s/^/[gst base plugins] /"
echo "avs-gst-plugins-base: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-libav.sh | sed "s/^/[libav] /"
echo "libav: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-gst-plugins-good.sh | sed "s/^/[gst bad plugins] /"
echo "avs-gst-plugins-bad: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-gst-plugins-bad.sh | sed "s/^/[gst good plugins] /"
echo "avs-gst-plugins-good: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-portaudio.sh | sed "s/^/[portaudio] /"
echo "portaudio: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-sensory.sh | sed "s/^/[sensory] /"
echo "sensory: $SECONDS" >> $TIMER

$SCRIPTS_DIR/avs-getsdk.sh | sed "s/^/[sdk download] /"
echo "getsdk: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-configsdk.sh | sed "s/^/[sdk config] /"
echo "configsdk: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-buildsdk.sh | sed "s/^/[sdk build] /"
echo "buildsdk: $SECONDS" >> $TIMER

$SCRIPTS_DIR/avs-pyauth.sh | sed "s/^/[authorisation] /"

popd

echo Available aliases:
echo +++ avsmake
echo +++ avsrun
echo +++ avsunit
echo +++ avsintegration
echo This script has not installed any i2s devices
echo Find and run avs-i2si2c.sh to do this
