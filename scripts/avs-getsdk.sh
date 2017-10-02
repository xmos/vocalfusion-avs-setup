#!/usr/bin/env bash
cd $HOME/AVS_SDK
git clone -b xmos git://github.com/xmos/avs-device-sdk.git

cd $HOME/BUILD

wget https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_02._TTH_.mp3 -O tmr.wav
wget https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_02_short._TTH_.wav -O tmr_sht.wav
wget https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_01._TTH_.mp3 -O alrm.wav
wget https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_01_short._TTH_.wav -O alrm_sht.wav
