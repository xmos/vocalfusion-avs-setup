#!/usr/bin/env bash
cd $SOURCE_FOLDER
sudo chown -R $USER $LOCAL_BUILD
cp alexa-rpi/lib/libsnsr.a $LOCAL_BUILD/lib
cp alexa-rpi/include/snsr.h $LOCAL_BUILD/include
mkdir $LOCAL_BUILD/models
cp alexa-rpi/models/spot-alexa-rpi-31000.snsr $LOCAL_BUILD/models
