#!/bin/sh

echo "Starting Companion Service"
cd /home/pi/Desktop/alexa-avs-sample-app/samples/companionService
lxterminal -e "npm start"

sleep 2
echo "Starting Java Client"
cd /home/pi/Desktop/alexa-avs-sample-app/samples/javaclient
lxterminal -e "mvn exec:exec"

sleep 10
echo "Starting Sensory Keyword Agent"
cd /home/pi/Desktop/alexa-avs-sample-app/samples/wakeWordAgent/src
lxterminal -e "./wakeWordAgent -e sensory"
