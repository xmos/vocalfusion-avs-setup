#!/bin/bash

# Update Linux to newest version

# Edit /boot/config.txt file to enable i2s
sed -i -e 's/#dtparam=i2s=on/dtparam=i2s=on/' /boot/config.txt

# Add modules to enable the I2C Peripherals and Direct Memory Access Controller modules
echo -e 'snd_soc_bcm2708 \n snd_soc_bcm2708_i2s \n bcm2708_dmaengine' >> /etc/modules

# Download kernal source
sudo apt-get install bc
sudo apt-get install libncurses5-dev
git clone http://github.com/notro/rpi-source
cd rpi-source
python rpi-source
cd ..

# Modify the driver source and build the modules needed.
# Build simple sound card driver
mkdir snd_driver
cd snd_driver
cp ../linux/sound/soc/generic/simple-card.c ./asoc_simple_card.c

# correcting in asoc_simple_card.c
sed -i "213i ret = snd_soc_dai_det_bclk_ratio(cpu, 64);pr_alert("BCLK ratio set to 64!\n");" asoc_simple_card.c

# Create Makefile
echo -e "obj-m := asoc_simple_card.o \nKDIR := /lib/modules/$(shell uname -r)/build \nPWD := $(shell pwd) \ndefault: \n\t$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules" > Makefile
# Build the module and insert it into the kernal
make
sudo insmod asoc_simple_card.ko
cd ..

# Build loader
cd loader
make

# Create Makefile
echo -e "obj-m := loader.o\n KDIR := /lib/modules/$(shell uname -r)/build\n PWD := $(shell pwd)\n default:\n \t$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules" > Makefile

# Build Makefile
make
sudo insmod loader.ko
cd ~

# Setup virtual capture device
echo -e "pcm.monocard {\n
type plug\n
slave.pcm "plughw:1,0"\n
slave.channels 2\n
slave.rate 16000\n
}\n
\n
ctl.monocard {\n
type hw\n
card 1\n
device 0\n
}\n
\n
pcm.!default {\n
type asym\n
playback.pcm {\n
type hw\n
card 0\n
}\n
capture.pcm {\n
type plug\n
slave.pcm "monocard"\n
}\n
}\n
\n
ctl.!default {\n
type asym\n
playback.pcm {\n
type hw\n
card 0\n
}\n
capture.pcm {\n
type plug\n
slave.pcm "monocard"\n
}\n
}" > ~/.asoundrc

# Apply changes
sudo /etc/init.d/alsa-utils restart

# Create cronjob to make it available after each reboot
echo -e "cd ~\n sudo insmod snd_driver/asoc_simple_card.ko\n sudo insmod loader/loader.ko" > load_i2s_driver.sh
echo "@reboot sh /home/pi/load_i2s_driver.sh" >> crontab

# Enable I2C
sed -i -e 's/#dtparam=i2c_arm=on/dtparam=i2c_arm=on/' /boot/config.txt
echo "i2c-bcm2708" >> /etc/modules-load.d/modules.conf
echo "options i2c-bcm2708 combined=1" >> /etc/modprobe.d/i2c.conf

# I2C Control Setup
git clone https://github.com/kadamski/i2c-gpio-param.git
cd i2c-gpio-param
make

# Insert module into the kernal
echo -e "# start i2c-gpio directory\n
cd /home/pi/i2c-gpio-param\n
# load the i2c bit banged driver\n
sudo insmod i2c-gpio-param.ko\n
# instantiate a driver at bus id=1 onsame pins as hw i2c with 1sec timeout\n
sudo bash -c 'echo "1 2 3 5 100 0 0 0" > /sys/class/i2c-gpio/add_bus'\n
# remove the default i2c-gpio instance\n
sudo bash -c 'echo "7" > /sys/class/i2c-gpio/remove_bus'\n
# returnt o previous dir\n
cd /home/pi/" > load_i2c-gpio_driver.sh

# Run I2C control shell
sh load_i2c-gpio_driver.sh

# add to cron job to load on every boot
echo "@reboot sh /home/pi/load_i2c-gpio_driver.sh" >> crontab
