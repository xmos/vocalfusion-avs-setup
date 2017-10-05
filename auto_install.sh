#!/usr/bin/env bash

SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"/scripts
source $SCRIPTS_DIR/avs-config.sh

SENSORY_MODEL_HASH_1=a8befe708af1aa80c32bce5219312a4ec439a0b0
SENSORY_MODEL_HASH_2=ddbc9040e24ed06aafe402017fa640b86d3520b3
SENSORY_MODEL_HASH_3=43b5cb246cb8422a8f39ae92d3e372dc19b98243

# Select Sensory version to use (default is 2)
SENSORY_MODEL_HASH=$SENSORY_MODEL_HASH_2

pushd .

# Set environment variables and create folders
if [ -z $SDK_SRC ]; then
	source $SCRIPTS_DIR/avs-init.sh
fi

mkdir -p $SOURCES_FOLDER
mkdir -p $SDK_BUILD
mkdir -p $THIRD_PARTY
mkdir -p $SOUND_FILES

# Set authentication information
if [ -z $SDK_CONFIG_CLIENT_ID ]; then
	if  [ ! -e $SCRIPTS_DIR/AlexaClientSDKConfig.json ]; then
		source $SCRIPTS_DIR/avs-userinput.sh
	fi
fi

# Clone sensory and complete license
if [ ! -d $THIRD_PARTY/alexa-rpi ]; then
	cd $THIRD_PARTY
	git clone git://github.com/Sensory/alexa-rpi.git
	cd alexa-rpi
	git checkout $SENSORY_MODEL_HASH -- models/spot-alexa-rpi-31000.snsr
fi
if [ -e $THIRD_PARTY/alexa-rpi/bin/license.sh ]; then
	bash $THIRD_PARTY/alexa-rpi/bin/license.sh
fi

TIMER=$SCRIPTS_DIR/time_taken.txt
SECONDS=0
$SCRIPTS_DIR/i2s_i2c_setup.sh | sed "s/^/[audio setup] /"
echo "audio-setup: $SECONDS" > $TIMER
$SCRIPTS_DIR/avs-getdepbin.sh | sed "s/^/[apt-get dependencies] /"
echo "apt-get deps: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-getdepsrc.sh | sed "s/^/[get sources] /"
echo "getsrc: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-portaudio.sh | sed "s/^/[portaudio] /"
echo "portaudio: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-sensory.sh | sed "s/^/[sensory] /"
echo "sensory: $SECONDS" >> $TIMER

if [ -e /usr/share/alsa/pulse-alsa.conf ] ; then
	# Rename existing file
	sudo mv /usr/share/alsa/pulse-alsa.conf  /usr/share/alsa/pulse-alsa.conf.bak
	sudo mv ~/.config/lxpanel/LXDE-pi/panels/panel ~/.config/lxpanel/LXDE-pi/panels/panel.bak
fi

$SCRIPTS_DIR/avs-getsdk.sh | sed "s/^/[sdk download] /"
echo "getsdk: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-configsdk.sh | sed "s/^/[sdk config] /"
echo "configsdk: $SECONDS" >> $TIMER
$SCRIPTS_DIR/avs-buildsdk.sh | sed "s/^/[sdk build] /"
echo "buildsdk: $SECONDS" >> $TIMER

echo "####~~~~BUILD TIMES~~~~####"
$SCRIPTS_DIR/convert_times.py

$SCRIPTS_DIR/avs-pyauth.sh | sed "s/^/[authorisation] /"

popd

echo Available aliases:
echo +++ avsmake
echo +++ avsrun
echo +++ avsunit
echo +++ avsintegration
echo To enable the i2s device, this pi must now be rebooted
echo type 'sudo reboot' below to do this
