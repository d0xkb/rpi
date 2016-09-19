#!/bin/bash
#usage: curl -Lo- http://raw.github.com/dakb/rpi/master/rpi_run.sh | bash

#user check
if [ "$UID" -ne "0" ]
then
	echo "Use this script as root."
	exit 1
else

#variables
packages="htop tcpdump iotop rsync dnsutils vim bc"
services="hciuart.service bluetooth.service avahi-daemon.service"
temp="http://raw.github.com/d0xkb/rpi/master/temp.sh"
tconf="http://raw.github.com/d0xkb/rpi/master/time.sh"

#update and upgrade via apt
apt-get -q update
apt-get -q -y upgrade >/dev/null
echo "[i]apt update and upgrade completed"

#temperature script
wget -q $temp -P /usr/bin/
chmod u+x /usr/bin/temp.sh
echo "[+]temperature script downloaded and ready"

#time setup
wget -q $tconf -P /tmp/
bash /tmp/time.sh >/dev/null
echo "[i]time setup completed"

#vim color syntax
echo "syntax on" > ~/.vimrc
echo "[+]vim syntax colored"

#install additional packages
apt-get -q -y install $packages >/dev/null
echo "[+]additional packages installed"

#disable few services
systemctl disable $services >/dev/null
echo "[-]some services disabled for autostart"

#unload wifi/bt drivers
cat > /etc/modprobe.d/raspi-blacklist.conf <<EOF
#wifi kernel modules
blacklist brcmfmac
blacklist brcmutil

#bt kernel modules
blacklist btbcm
blacklist hci_uart
EOF
echo "[-]wifi/bt drivers unloaded"

#create and mount ramdisk
mkdir /ramdisk
cat >> /etc/fstab <<EOF

#ramdisk
tmpfs   /ramdisk  tmpfs nodev,nosuid,size=128M  0 0
EOF

mount -a -t tmpfs
echo "[+]ramdisk created and mounted as /ramdisk"

#delete and link apt cache
rm -rf /var/cache/apt/archives
ln -s /ramdisk /var/cache/apt/archives
echo "[i]apt archive linked to ramdisk"

#persistently disable swap
swapoff --all
apt-get -q -y remove dphys-swapfile >/dev/null
echo "[-]swap disabled"

#.bashrc moficiations for root
cat >> /root/.bashrc <<EOF

#unlimited history length
HISTSIZE=
HISTFILESIZE=

#simple list alias
alias ll='ls -la --color=auto'
EOF

cat >> /home/pi/.bashrc <<EOF

#faster switch
alias s='sudo su -'
EOF
echo "[i]bashrc modified"

#cleaning via apt
apt-get -q autoclean >/dev/null
apt-get -q -y autoremove >/dev/null
echo "[i]apt clean, unused packages removed"

#done, restart
shutdown -r now
