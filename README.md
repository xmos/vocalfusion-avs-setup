#i2s_i2c_pi_setup

You will need an amazon developer account (https://developer.amazon.com) and a device set up (https://github.com/alexa/alexa-avs-sample-app/wiki/Create-Security-Profile).

If you already have a working AlexaClientSDKConfig.json (with refresh token)
put it in i2s_i2c_pi_setup/scripts/ folder and this will be detected.
Otherwise, keep the webpage open on the pi so you can copy these details across when asked.

Download NOOBS image from https://downloads.raspberrypi.org/NOOBS/images/NOOBS-2017-07-05/NOOBS_v2_4_2.zip
or
Download Raspbian Jessie images from https://downloads.raspberrypi.org/raspbian/images/raspbian-2017-07-05/2017-07-05-raspbian-jessie.zip

Visit https://elinux.org/RPi_Easy_SD_Card_Setup for easy instructions on how to flash this sd card and install raspbian

Once inside Raspbian, open a terminal and type
> git clone -b SDK_scripts https://github.com/xmos/i2s_i2c_pi_setup

enter github username and password

Run the main script
> . i2s_i2c_pi_setup/auto_install.sh

Enter amazon developer details if necessary

Wait for sensory to clone

Press enter to read and accept the license

The rest takes a while (one example):
['apt-get deps: 3m53s',
 'getsrc: 2m33s',
 'nghttp2: 1m35s',
 'openssl: 10m0s',
 'curl: 3m59s',
 'gstreamer: 5m53s',
 'avs-gst-plugins-base: 6m56s',
 'libav: 23m29s',
 'avs-gst-plugins-bad: 9m13s',
 'avs-gst-plugins-good: 10m51s',
 'portaudio: 1m4s',
 'sensory: 0m0s',
 'getsdk: 0m23s',
 'configsdk: 0m14s',
 'buildsdk: 36m23s']
TOTAL: 1h56m26s

open localhost:3000 in browser and enter credentials

If you want to use the board in i2s mode, run i2s_i2c_setup.sh
This step is hard to reverse so be ready to clean install the os or do any usb testing first

avsrun [DEBUG9]