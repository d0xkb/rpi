Raspberry Pi 3 post installation script
=====================================
this is my first script to RUN after setting up SD card for Raspberry Pi 3. It should take something between 5-10 minutes and RPi is then automatically rebooted.

Usage
-----
````
apt-get update && apt-get -y install unzip
wget https://github.com/d0xkb/rpi/archive/master.zip
unzip master.zip && cd rpi-master
bash run.sh
````
