# Setting up the Alexa Voice Services SDK on a Raspberry Pi

## Prerequisites
You will need an amazon developer account (https://developer.amazon.com) and a device set up (https://github.com/alexa/alexa-avs-sample-app/wiki/Create-Security-Profile).

If you already have a working AlexaClientSDKConfig.json (with refresh token)
put it in i2s_i2c_pi_setup/scripts/ folder once you have cloned the repo and this will be detected.
Otherwise, keep the webpage open on the pi so you can copy these details across when asked.

Download NOOBS image from https://downloads.raspberrypi.org/NOOBS/images/NOOBS-2017-07-05/NOOBS_v2_4_2.zip
or
Download Raspbian Jessie images from https://downloads.raspberrypi.org/raspbian/images/raspbian-2017-07-05/2017-07-05-raspbian-jessie.zip

Visit https://elinux.org/RPi_Easy_SD_Card_Setup for easy instructions on how to flash this sd card and install raspbian

## Installation
1. Once inside Raspbian, open a terminal and type `git clone https://github.com/xmos/i2s_i2c_pi_setup`
enter your github username and password if prompted

2. Run the main script, sourcing it with `source i2s_i2c_pi_setup/auto_install.sh`

3. Enter Amazon developer details if necessary

4. Wait for the Sensory repo to clone and press enter to read and accept the license

5. Wait for the script to complete the installation, this can take a very long time (an example given)
   - apt-get deps: 3m53s
   - getsrc: 2m33s
   - nghttp2: 1m35s
   - openssl: 10m0s
   - curl: 3m59s
   - gstreamer: 5m53s
   - gst-plugins-base: 6m56s
   - libav: 23m29s
   - gst-plugins-bad: 9m13s
   - gst-plugins-good: 10m51s
   - portaudio: 1m4s
   - sensory: 0m1s
   - getsdk: 0m23s
   - configsdk: 0m14s
   - buildsdk: 36m23s

   - TOTAL: 1h56m26s

6. Open localhost:3000 in browser and enter credentials, you won't have to do this if you already have a valid configuration file.
If you want to add one later, paste it into `~/BUILD/Integration/`

7. Type `sudo reboot` to reboot the Pi

8. Enter `avsrun [DEBUG9]` to run the sample app, `avsunit` to run the unit tests and `avsintegration` to run the integration tests.
