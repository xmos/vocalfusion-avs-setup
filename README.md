# xCORE VocalFusion Kits for Amazon AVS on a Raspberry Pi

This repository provides a simple-to-use automated script to install the Amazon AVS SDK on a Raspberry Pi and configure the Raspberry Pi to use the appropriate **xCORE VocalFusion Kit for Amazon AVS**.

The XMOS **xCORE VocalFusion kits for Amazon AVS** provides far-field voice capture using one of the XMOS XVF3000, XVF3100, XVF3500, XVF3510 OR XVF3610 voice processors.

Combined with a Raspberry Pi running the Amazon Alexa Voice Service (AVS) Software Development Kit (SDK), these kits allow you to quickly prototype and evaluate talking with Alexa.

To find out more, visit:

   - [XVF3610/3615 & XVF3500](https://www.xmos.ai/vocalfusion-voice-interfaces/)
   - [XVF3510](https://www.xmos.ai/xvf3510/)
   - [XVF3100/3000](https://www.xmos.ai/vocalfusion-conference-calling/)

Information on the AVS tools and developer support can be found [here](https://developer.amazon.com/alexa-voice-service)

## Prerequisites
You will need:

- Either

   - **Voice Reference Design Evaluation Kit**: XK-VOICE-L71, or
   - **xCORE VocalFusion XVF3510 Kit for Amazon AVS**: XK-VF3510-L71-AVS, or
   - **xCORE VocalFusion Stereo 4-Mic Kit for Amazon AVS**: XK-VF3500-L33-AVS, or
   - **xCORE VocalFusion 4-Mic Kit for Amazon AVS**: XK-VF3000-L33-AVS

- Either

   - Raspberry Pi 3 with Micro-USB power supply (min. 2A) and HDMI cable, or
   - Raspberry Pi 4 with USB-C power supply (min. 3A) and Micro HDMI to Standard HDMI (A/M) Cable

- MicroSD card (min. 16GB)
- Powered speaker(s) with audio 3.5mm analogue plug

   Mono or Stereo for the XVF3615, XVF3610, XVF3510 and XVF3500, or
   Mono only for the XVF3100 and XVF3000

- Monitor with HDMI input
- USB keyboard and mouse
- Fast-Ethernet connection or WiFi with internet connectivity

- [for -UA configurations] USB A to USB Micro B cable

You will also need an Amazon Developer account from [here](https://developer.amazon.com)

## Hardware Setup
Set up your hardware by following the **Hardware Setup Guide** for your product.

   - [XVF3610/3615](https://www.xmos.ai/file/xvf3610-Quick-start-guide)
   - [XVF3510](https://www.xmos.ai/file/xvf3510-dev-kit-setup-guides)
   - [XVF3500](https://www.xmos.ai/file/xvf3500-dev-kit-setup-guides)
   - [XVF3000/3100](https://www.xmos.ai/file/xvf3000-3100-dev-kit-setup-guides)

If you are using the -UA variant, connect a USB cable from the micro USB port on the XMOS board to a free
USB port on the Raspberry Pi.

## Firmware Upgrade
Once the hardware is setup, upgrade the firmware on your AVS development kit. The firmware can be found here:

   - [XVF3610-INT](https://www.xmos.ai/file/xvf3610-int)
   - [XVF3610-UA](https://www.xmos.ai/file/xvf3610-ua)

   - XVF3615  - Amazon licensing terms require additional approvals to obtain XVF3615 firmware - Please contact XMOS [here](https://www.xmos.ai/contact/)

   - [XVF3510-INT](https://www.xmos.ai/file/xvf3510-int-release)
   - [XVF3510-UA](https://www.xmos.ai/file/xvf3510-ua-release)

   - [XVF3500](https://www.xmos.ai/file/vocalfusion-stereo-evaluation-binaries)
   - [XVF3000/3100](https://www.xmos.ai/file/vocalfusion-speaker-evaluation-binaries)

To upgrade the firmware you will need an XMOS xTAG adapter. The appropriate xTAG for the board
is supplied with each evaluation kit.


## Create a Raspberry Pi system disk

Follow the instructions in steps 1 to 4 from the [Setup section here](https://github.com/xmos/vocalfusion-rpi-setup/blob/v5.8.0/README.md#setup).

## AVS SDK installation and Raspberry Pi audio setup

1. Open a terminal window on the Raspberry Pi desktop and clone the vocalfusion-avs-setup repository:

   ```git clone https://github.com/xmos/vocalfusion-avs-setup```

   **DO NOT** use the command 'apt update' to update the software database. This will cause the installation to fail. **DO NOT** update the kernel, as this will cause the audio sub-sytem to fail.

2. Register an AVS product, create a security profile and save a *config.json* file by following the steps from [here](https://developer.amazon.com/en-US/docs/alexa/alexa-voice-service/register-a-product.html). It is strongly recommended that the config.json file should be saved onto a USB memory stick for future use.

3. Close the browser and any other applications to avoid the Raspberry Pi freezing during the AVS SDK installation.

4. Copy the *config.json* from the location it was saved to in step 4. into the directory `vocalfusion-avs-setup`

5. Run the installation script by entering:

   ``` cd vocalfusion-avs-setup```

   And then either

   - XVF3615-INT: ```./auto_install.sh xvf3615-int```
   - XVF3615-UA: ```./auto_install.sh xvf3615-ua```
   - XVF3610-INT: ```./auto_install.sh xvf3610-int```
   - XVF3610-UA: ```./auto_install.sh xvf3610-ua```
   - XVF3510-INT: ```./auto_install.sh xvf3510-int```
   - XVF3510-UA: ```./auto_install.sh xvf3510-ua```
   - XVF3500: ```./auto_install.sh xvf3500```
   - XVF3100: ```./auto_install.sh xvf3100```
   - XVF3000: ```./auto_install.sh xvf3100```

   The XVF3615-INT and XVF3615-UA devices have an internal keyword detector which switches the AVS console to listening mode when saying "Alexa". The other devices do not have any keyword detection mechanism, neither on the device nor on host. Before the user issues a command, they must use the 'tap-to-talk' option, by pressing 't' on the AVS console.

   Read and accept the AVS Device SDK license agreement.

6. You will be asked whether you want the Sample App to run automatically when the Raspberry Pi boots. It is recommended that you respond "yes" to this option.

7. Follow the instructions from the console and wait for the script to complete the installation. The script is configuring the Raspberry Pi audio system, downloading and updating dependencies, building and configuring the AVS Device SDK. It takes around 30 minutes to complete.

8. Enter `sudo reboot` to reboot the Raspberry Pi and complete the installation.

9. If you selected the option to run the Sample App on boot there should now be a terminal open with the sample app runnning. If the sample app is not running, then open a terminal and use `avsrun` to start the app. You should now be able to complete the registration by following the instructions on the screen, although you may need to scroll back to see them. A code will be printed on the screen, and you will be prompted to visit https://amazon.com/us/code, log in to your developer account, and enter the code when prompted.

10. Now you can execute an AVS command such as "Alexa, what time is it?".

   On the XMOS **xCORE VocalFusion XVF3510 Kit for Amazon AVS**, the LED on the Pi HAT board will change colour when the system hears the "Alexa" keyword, and will then cycle back and forth whilst waiting for a response from the Amazon AVS server.

   On the XMOS **xCORE VocalFusion Stereo 4-Mic Kit for Amazon AVS** and **xCORE VocalFusion 4-Mic Kit for Amazon AVS**, the LEDs on the development board should reflect the approximate direction from which the microphones are receiving a stimulus.

## Choose a different keyword detection mechanism

Every product in step 5. in the section above, has a default keyword detection mechanism. This can be overriden from the command line, by using the CLI argument `-w` with the `auto_install.sh` script. The possible options for the `-w` argument are:

   - G: GPIO triggered keyword detector, this option only works in combination with the XVF3615-INT device
   - H: HID triggered keyword detector, this option only works in combination with the XVF3615-UA device

For example to configure XVF3610-INT to use the Amazon keyword detection, the user must request the necessary instructions and files from Amazon and update the scripts and files in `avs-device-sdk` as described by Amazon. The Raspberry Pi can be configured by following the steps in the section above and replace the command in step 5. with:

```./auto_install.sh xvf3610-int -w A```

## Running the AVS SDK Sample App
The automated installation script creates a number of aliases which can be used to execute the AVS Device SDK client, or run the unit tests:
- `avsrun` to run the Sample App.

## Reinstalling the AVS SDK and Raspberry Pi audio setup

In case of re-installation, please repeat the full procedure as described in the sections "Create a Raspberry Pi system disk" and "AVS SDK installation and Raspberry Pi audio setup". It is recommended the re-installation procedure starts always from a blank SD card.
