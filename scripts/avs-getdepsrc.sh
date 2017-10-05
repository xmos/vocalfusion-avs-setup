#!/usr/bin/env bash
if [ -z $THIRD_PARTY ]; then
	echo "Environment not set correctly, delete ~/.bash_aliases and try again"
	exit 1
fi

cd $THIRD_PARTY
wget -c http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz
tar zxf pa_stable_v190600_20161030.tgz
