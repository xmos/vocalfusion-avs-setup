#!/usr/bin/env bash
set -e

SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

pushd .

if [ -z $SDK_SRC ]; then
	$SCRIPTS_DIR/avs-init.sh
	echo "Run me again in a new terminal"
	echo "Press any key to exit"
	read -n 1
	exit 0
fi

if [ -z $SDK_CONFIG_CLIENT_ID ] && [ ! -e $SCRIPTS_DIR/AlexaClientSDKConfig.json ]; then
	$SCRIPTS_DIR/avs-userinput.sh
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
