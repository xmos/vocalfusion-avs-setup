#!/bin/sh

cd /home/pi/Desktop/alexa-avs-sample-app/samples/companionService
lxterminal -e "npm start"

cd /home/pi/Desktop/alexa-avs-sample-app/samples/javaclient
lxterminal -e "mvn exec:exec"

cd /home/pi/Desktop/alexa-avs-sample-app/samples/wakeWordAgent/src
lxterminal -e "./wakeWordAgent -e sensory"
