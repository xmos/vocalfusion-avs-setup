# xCORE VocalFusion Kit for Amazon AVS on a Raspberry Pi

The XMOS **xCORE VocalFusion Kit for Amazon AVS** provides far-field voice capture using the XMOS XVF3100, XVF3500, and XVF3510 voice processors.

Combined with a Raspberry Pi running the Amazon Alexa Voice Service (AVS) Software Development Kit (SDK), this kit allows you to quickly prototype and evaluate talking with Alexa.

To find out more, visit: https://xmos.com/vocalfusion-avs  
and: https://developer.amazon.com/alexa-voice-service

This repository provides a simple-to-use automated script to install the Amazon AVS SDK on a Raspberry Pi and configure the Raspberry Pi to use the **xCORE VocalFusion Kit for Amazon AVS** for audio.

## Prerequisites
You will need:

- Either

   **xCORE VocalFusion XVF3510 Kit for Amazon AVS**: XK-VF3510-L71, or  
   **xCORE VocalFusion Stereo 4-Mic Kit for Amazon AVS**: XK-VF3500-L33-AVS, or  
   **xCORE VocalFusion 4-Mic Kit for Amazon AVS**: XK-VF3000-L33-AVS

- Either

   Raspberry Pi 3 with Micro-USB power supply (min. 2A) and HDMI cable, or  
   Raspberry Pi 4 with USB-C power supply (min. 3A) and Micro HDMI to Standard HDMI (A/M) Cable

- MicroSD card (min. 16GB)
- Powered speakers with audio 3.5mm analogue plug

   Stereo for the XVF3510 and XVF3500, or  
   Mono for the XVF3100
   
- Monitor with HDMI input
- Fast-Ethernet connection or WiFi with internet connectivity

You will also need an Amazon Developer account: https://developer.amazon.com

## Hardware Setup
Set up your hardware by following the **Hardware Setup Guide** for your product.

## Firmware Upgrade
Once the hardware is setup, upgrade the firmware on your AVS development kit. The firmware can be found here:  
   https://www.xmos.ai/file/xvf3510-int-release for the XVF3510  
   https://www.xmos.ai/file/vocalfusion-stereo-evaluation-binaries for the XVF3500  
   https://www.xmos.ai/file/vocalfusion-speaker-evaluation-binaries for the XVF3100  
To upgrage the firmware you will need the XMOS xTAG adapter https://www.xmos.ai/xtag-debug-adapter/

## AVS SDK installation and Raspberry Pi audio setup
The **Getting Started Guide** details setup steps up until this point. What follows are setup steps specific to the AVS SDK.

1. Install Raspbian (Buster) on the Raspberry Pi.

   NOOBS is available here: http://raspberrypi.org/downloads/
   
   IMPORTANT: To prevent inadvertent (and possibly incompatible) updates, ensure that there are no network cables connected to the Pi. 
   
   On first boot, follow the instructions to set your locale settings, connect to a WiFi network and update the kernel.

2. Ensure running kernel version matches headers kernel headers package. A typical system requires the following `--reinstall` command:

   ```
   sudo apt-get update
   sudo apt-get install --reinstall raspberrypi-bootloader raspberrypi-kernel
   ```

   followed by a reboot.

3. Clone the vocalfusion-avs-setup repository:

   ```git clone https://github.com/xmos/vocalfusion-avs-setup```

4. Close any other application such as browsers to avoid the Raspberry Pi freezing during the AVS SDK installation.

5. Register an AVS product, create a security profile and save a *config.json* file by following https://developer.amazon.com/en-US/docs/alexa/alexa-voice-service/register-a-product.html

6. Copy the *config.json* into the directory `vocalfusion-avs-setup`

7. Run the installation script by entering:

   ``` cd vocalfusion-avs-setup```

   And then either
   
   ```./auto_install.sh xvf3510``` for the xCORE VocalFusion XVF3510, or  
   ```./auto_install.sh xvf3500``` for the xCORE VocalFusion XVF3500, or  
   ```./auto_install.sh xvf3100``` for the xCORE VocalFusion XVF3100

   Read and accept the AVS Device SDK license agreement.

8. You will be asked whether you want the Sample App to run automatically when the Raspberry Pi boots. It is recommended that you respond "yes" to this option.

9. Read and accept the Sensory license agreement. Wait for the script to complete the installation. The script is configuring the Raspberry Pi audio system, downloading and updating dependencies, building and configuring the AVS Device SDK. It takes around 30 minutes to complete.

10. Enter `sudo reboot` to reboot the Raspberry Pi and complete the installation.

11. If you selected the option to run the Sample App on boot you should now be able to complete the registration by following the instructions on the screen, although you may need to scroll back to see them. A code will be printed on the screen, and you will be prompted to visit https://amazon.com/us/code, log in to your developer account, and enter the code when prompted.

12. Now you can execute an AVS command such as "Alexa, what time is it?".

   On the XMOS **xCORE VocalFusion XVF3510 Kit for Amazon AVS**, the LED on the Pi HAT board will change colour when the system hears the "Alexa" keyword, and will then cycle back and forth whilst waiting for a response from the Amazon AVS server.

   On the XMOS **xCORE VocalFusion Stereo 4-Mic Kit for Amazon AVS** and **xCORE VocalFusion 4-Mic Kit for Amazon AVS**, the LEDs on the development board should reflect the approximate direction from which the microphones are receiving a stimulus.

## Running the AVS SDK Sample App
The automated installation script creates a number of aliases which can be used to execute the AVS Device SDK client, or run the unit tests:
- `avsrun` to run the Sample App.

## Changing Sensory operating point

To change to operating point of the Sensory keyword engine, edit the shell script run by the `avsrun` alias: 

   `~/sdk-folder/avs-device-sdk/tools/Install/.avsrun-startup.sh`
   
and change the third argument to SampleApp from the default value of `12` to the desired value.
