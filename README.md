# xCORE VocalFusion Kits for Amazon AVS on a Raspberry Pi

This repository provides a simple-to-use automated script to install the Amazon AVS SDK on a Raspberry Pi and configure the Raspberry Pi to use the appropriate **xCORE VocalFusion Kit for Amazon AVS**.

The XMOS **xCORE VocalFusion Kit for Amazon AVS** provides far-field voice capture using one of the XMOS XVF3000, XVF3100, XVF3500, XVF3510 OR XVF3610 voice processors.

Combined with a Raspberry Pi running the Amazon Alexa Voice Service (AVS) Software Development Kit (SDK), these kits allow you to quickly prototype and evaluate talking with Alexa.

To find out more, visit: https://www.xmos.ai/vocalfusion-voice-interfaces/ (XVF3610/3500),
https://www.xmos.ai/xvf3510/ (XVF3510)
or https://www.xmos.ai/vocalfusion-conference-calling/ (XVF3100/3000)
and: https://developer.amazon.com/alexa-voice-service

## Prerequisites
You will need:

- Either

   - **xCORE VocalFusion XVF3610/XVF3615 Kit for Amazon AVS**: XK-VOICE-L71, or
   - **xCORE VocalFusion XVF3510 Kit for Amazon AVS**: XK-VF3510-L71, or
   - **xCORE VocalFusion Stereo 4-Mic Kit for Amazon AVS**: XK-VF3500-L33-AVS, or
   - **xCORE VocalFusion 4-Mic Kit for Amazon AVS**: XK-VF3000-L33-AVS

- Either

   - Raspberry Pi 3 with Micro-USB power supply (min. 2A) and HDMI cable, or
   - Raspberry Pi 4 with USB-C power supply (min. 3A) and Micro HDMI to Standard HDMI (A/M) Cable

- MicroSD card (min. 16GB)
- Powered speakers with audio 3.5mm analogue plug

   Stereo for the XVF3615, XVF3610, XVF3510 and XVF3500, or
   Mono for the XVF3100 and XVF3000

- Monitor with HDMI input
- USB keyboard and mouse
- Fast-Ethernet connection or WiFi with internet connectivity

You will also need an Amazon Developer account: https://developer.amazon.com

## Hardware Setup
Set up your hardware by following the **Hardware Setup Guide** for your product.

   - XVF3615: https://www.xmos.ai/file/xvf3615-dev-kit-setup-guides
   - XVF3610: https://www.xmos.ai/file/xvf3610-dev-kit-setup-guides
   - XVF3510: https://www.xmos.ai/file/xvf3510-dev-kit-setup-guides
   - XVF3500: https://www.xmos.ai/file/xvf3500-dev-kit-setup-guides
   - XVF3100: https://www.xmos.ai/file/xvf3000-3100-dev-kit-setup-guides
   - XVF3000: https://www.xmos.ai/file/xvf3000-3100-dev-kit-setup-guides

## Firmware Upgrade
Once the hardware is setup, upgrade the firmware on your AVS development kit. The firmware can be found here:

   - XVF3615-INT: https://www.xmos.ai/file/xvf3615-int-release
   - XVF3615-UA: https://www.xmos.ai/file/xvf3615-ua-release
   - XVF3610-INT: https://www.xmos.ai/file/xvf3610-int-release
   - XVF3610-UA: https://www.xmos.ai/file/xvf3610-ua-release
   - XVF3510-INT: https://www.xmos.ai/file/xvf3510-int-release
   - XVF3510-UA: https://www.xmos.ai/file/xvf3510-int-release
   - XVF3500: https://www.xmos.ai/file/vocalfusion-stereo-evaluation-binaries
   - XVF3100: https://www.xmos.ai/file/vocalfusion-speaker-evaluation-binaries
   - XVF3000: https://www.xmos.ai/file/vocalfusion-speaker-evaluation-binaries

To upgrade the firmware you will need the XMOS xTAG adapter https://www.xmos.ai/xtag-debug-adapter/

## Create a Raspberry Pi system disk

First, obtain the required version of the Raspberry Pi operating system, which is available here:

https://downloads.raspberrypi.org/raspbian/images/raspbian-2020-02-14/2020-02-13-raspbian-buster.zip

We cannot use the latest as updates to linux kernel v5 have broken the I2S sub-system.

Then, install the Raspberry Pi Imager on a host computer. Raspberry Pi Imager is available here:

https://www.raspberrypi.org/software/

Run the Raspberry Pi Imager, and select the 'CHOOSE OS' button. Scroll to the bottom of the displayed list, and select "Use custom".
Then select the file downloaded above (2020-02-13-raspbian-buster.zip) and select "Open". The archive file does not have to be unzipped, the imager software will do that.

Select the CHOOSE SD CARD button to which to download the image, and then select the "WRITE" button.

When prompted, remove the written SD card and insert it into the Raspberry Pi.

Connect up the keyboard, mouse, speakers and display to the Raspberry Pi and power up the system. Refer to the **Getting Started Guide** for your platform.

When the Raspberry Pi boots up, give these answers to the following questions:

- Welcome to the Raspberry Pi Desktop!: select 'Next'
- Set Country: Make the appropriate changes and select 'Next'
- Change Password: Set the password appropriately and select 'Next'
- Set Up Screen: Follow the instructions, and then select 'Next'
- Select WiFi Network: If you are using WiFi, select your SSID from the list and then select 'Next'
- (If you selected a WiFi network, you will be prompted to enter the password, and then select 'Next')
- Update Software: select **Skip**

**DO NOT FOLLOW THE PROMPT TO UPDATE THE SOFTWARE ON THE SYSTEM.** Set up the locale, and setup a network connect, but **DO NOT** update the software on the Raspberry Pi. This will update the kernel, and then the audio sub-system will not work.

## AVS SDK installation and Raspberry Pi audio setup

1. Open a terminal window on the Raspberry Pi desktop and clone the vocalfusion-avs-setup repository:

   ```git clone https://github.com/xmos/vocalfusion-avs-setup```

   **DO NOT** use the command 'apt update' to update the software database. This will cause the installation to fail. **DO NOT** update the kernel, as this will cause the audio sub-sytem to fail.

2. Register an AVS product, create a security profile and save a *config.json* file by following https://developer.amazon.com/en-US/docs/alexa/alexa-voice-service/register-a-product.html. It is strongly recommended that the config.json file should be saved onto a USB memory stick for future use.

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

   If you need to use the keyword detection using the GPIO2 pin, use the flag '-g' after the device name. If this option is not selected, the Sensory engine is used.

   Read and accept the AVS Device SDK license agreement.

6. You will be asked whether you want the Sample App to run automatically when the Raspberry Pi boots. It is recommended that you respond "yes" to this option.

7. Wait for the script to complete the installation. The script is configuring the Raspberry Pi audio system, downloading and updating dependencies, building and configuring the AVS Device SDK. It takes around 30 minutes to complete.

8. Enter `sudo reboot` to reboot the Raspberry Pi and complete the installation.

9. If you selected the option to run the Sample App on boot there should now be a terminal open with the sample app runnning. If the sample app is not running, then open a terminal and use `avsrun` to start the app. You should now be able to complete the registration by following the instructions on the screen, although you may need to scroll back to see them. A code will be printed on the screen, and you will be prompted to visit https://amazon.com/us/code, log in to your developer account, and enter the code when prompted.

10. Now you can execute an AVS command such as "Alexa, what time is it?".

   On the XMOS **xCORE VocalFusion XVF3510 Kit for Amazon AVS**, the LED on the Pi HAT board will change colour when the system hears the "Alexa" keyword, and will then cycle back and forth whilst waiting for a response from the Amazon AVS server.

   On the XMOS **xCORE VocalFusion Stereo 4-Mic Kit for Amazon AVS** and **xCORE VocalFusion 4-Mic Kit for Amazon AVS**, the LEDs on the development board should reflect the approximate direction from which the microphones are receiving a stimulus.

## Running the AVS SDK Sample App
The automated installation script creates a number of aliases which can be used to execute the AVS Device SDK client, or run the unit tests:
- `avsrun` to run the Sample App.

The XVF3615-INT and XVF3615-UA devices have an internal wakeword detector which switches the AVS console to listening mode when saying "Alexa". The other devices don't have any wakeword detection mechanism, neither on the device nor on host. Before the user issues a command, they must use the 'tap-to-talk' option, by pressing 't' on the AVS console.

## Reinstalling the AVS SDK and Raspberry Pi audio setup

In case of re-installation, please repeat the full procedure as described in the sections "Create a Raspberry Pi system disk" and "AVS SDK installation and Raspberry Pi audio setup". It is recommended the re-installation procedure starts always from a blank SD card.



