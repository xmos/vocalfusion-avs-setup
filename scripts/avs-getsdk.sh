#!/usr/bin/env bash

# Setup paths
SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" 
source $SCRIPTS_DIR/avs-config.sh

cd $SOURCES_FOLDER
git clone -b xmos_v1.4 git://github.com/xmos/avs-device-sdk.git

cd $SOUND_FILES
wget -c https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_02._TTH_.mp3 -O timer.wav
wget -c https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_02_short._TTH_.wav -O timer_short.wav
wget -c https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_01._TTH_.mp3 -O alarm.wav
wget https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_01_short._TTH_.wav -O alarm_short.wav
