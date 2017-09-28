#i2s_i2c_pi_setup

format sd card: (windows) diskpart -> list disk -> select disk * -> clean -> create part primary -> format fs=FAT32 quick

put NOOBS on formatted sd card

extract NOOBS so base folder is the drive

put in pi

install Jessie [10 min]

> git clone -b SDK_scripts https://github.com/xmos/i2s_i2c_pi_setup

enter github username and password

> . i2s_i2c_pi_setup/scripts/avs-MAIN.sh

Enter amazon dev details, 
or if you already have a working AlexaClientSDKConfig.json (with refresh)
put it in i2s_i2c_pi_setup/scripts/ folder

Wait for sensory to clone

Accept license

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

if using i2s:
	run $SCRIPTS_DIR/avs_i2si2c.sh

avsrun [DEBUG9]