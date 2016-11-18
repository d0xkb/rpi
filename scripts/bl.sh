#!/bin/bash

#blacklist wifi/bluetooth modules
cat > /etc/modprobe.d/raspi-blacklist.conf <<EOF
#wifi kernel modules
blacklist brcmfmac
blacklist brcmutil

#bt kernel modules
blacklist btbcm
blacklist hci_uart
EOF
