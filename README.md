# xCORE VocalFusion 4-Mic Kit for AVS and Amazon Alexa Voice Services SDK on a Raspberry Pi

The XMOS **xCORE VocalFusion 4-Mic Kit for AVS** provides far-field voice capture using the XMOS XVF3000 voice processor.

Combined with a Raspberry Pi running the Amazon Alexa Voice Service (AVS) Software Development Kit (SDK), this kit allows you to quickly prototype and evaluate talking with Alexa.

To find out more, visit: https://xmos.com/vocalfusion-avs  
and: https://developer.amazon.com/alexa-voice-service

This respository provides a simple-to-use automated script to install the Amazon AVS SDK on a Raspberry Pi and configure the Raspberry Pi to use the **xCORE VocalFusion 4-Mic Kit for AVS** for audio.

## Prerequisites
You will need:

- **xCORE VocalFusion 4-Mic Kit for Amazon AVS**: XK-VF3000-L33-AVS
- Raspberry Pi 3
- Micro-USB power supply (min. 2A)
- MicroSD card (min. 16GB)
- Powered mono speaker with audio 3.5mm analogue plug
- Monitor with HDMI input
- HDMI cable
- Fast-Ethernet connection with internet connectivity

You will also need an Amazon Developer account: https://developer.amazon.com 

## Hardware setup
Setup your hardware by following the **Hardware Setup** at: https://xmos.com/vocalfusion-avs

## AVS SDK installation and Raspberry Pi audio setup
Full instructions to install the AVS SDK on to a Raspberry Pi and configure the audio to use the **xCORE VocalFusion 4-Mic Kit for AVS** are detailed in the **Getting Started Guide** available from: https://xmos.com/vocalfusion-avs.

Brief instructions and additional notes are below:

1. Install Raspbian (Stretch) on the Raspberry Pi.

2. Open a terminal on the Raspberry Pi and clone this respository:  
`cd ~; git clone https://github.com/xmos/vocalfusion-avs-setup`

3. Either:  
create a new Alexa device by following: https://github.com/alexa/alexa-avs-sample-app/wiki/Create-Security-Profile  
(Note: the *Allowed Origins* and *Allowed Return URLs* should use **http**, not https.)  
Or:  
use an existing Alexa device by placing your `AlexaClientSDKConfig.json` file (with a valid refresh token) in the `~/vocalfusion-avs-setup/scripts/` folder.

4. Run the installation script: `source ~/vocalfusion-avs-setup/auto_install.sh`  
If necessary, enter your Alexa device details (*ProductID*, *ClientID* and *ClientSecret*), a serial number and your location.  
Wait for the sensory (keyword detection) repository to clone, then read and accept the license agreement.  
Wait for the script to complete the installation. This can take a while, for example:  
   - audio-setup: 4m40s
   - apt-get deps: 3m14s
   - getsrc: 3m11s
   - portaudio: 1m1s
   - sensory: 0m1s
   - getsdk: 0m34s
   - configsdk: 0m17s
   - buildsdk: 24m2s
   - **TOTAL: 35m0s**

5. As a final step, the script will open http://localhost:3000 in a browser on the Raspberry Pi. Enter your Amazon Developer credentials and close the browser window when prompted. (You won't have to do this if you already have a valid configuration file.)  
If you see a `400 Bad Request - HTTP` error it may be necessary to add http:// URLs to your device origins and return fields. To do this, go to your amazon developer AVS home page (https://developer.amazon.com/avs/home.html) and from `My products` select `manage` and then `security profile`. Now add http://localhost:3000 to the `Allowed origins` and http://localhost:3000/authresponse to the `Allowed return URLs`. Now refresh the browser window with the original error.

If you want to add your own credentials configuration file later, paste it into: `~/BUILD/Integration/`

6. Enter `sudo reboot` to reboot the Raspberry Pi and complete the audio setup.

7. Enter `avsrun` to run the sample app, `avsunit` to run the unit tests and `avsintegration` to run the integration tests.
