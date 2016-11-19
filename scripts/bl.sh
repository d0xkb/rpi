#!/bin/bash

#blacklist wifi/bluetooth modules
cat > /etc/modprobe.d/raspi-blacklist.conf <<EOF
# disable wifi kernel modules
blacklist brcmfmac
blacklist brcmutil

# disable bluetooth kernel modules
blacklist btbcm
blacklist hci_uart

# blacklist intel_rapl kernel module to avoid "no valid rapl" error
blacklist intel_rapl
EOF
