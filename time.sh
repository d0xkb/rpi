#!/bin/bash

#install ntpdate and chrony
apt-get -q -y install ntpdate chrony

#services adjustment
systemctl disable fake-hwclock.service ntp.service
systemctl enable chrony.service

#set correct timezone
timedatectl set-ntp false
timedatectl set-timezone Europe/Prague

#create ntpdate config
cat > /etc/default/ntpdate <<EOF
NTPDATE_USE_NTP_CONF=no
NTPSERVERS="ntp.nic.cz"
NTPOPTIONS="u"
EOF

#create chrony config
cat > /etc/chrony.conf <<EOF
server ntp.nic.cz prefer iburst
server tik.cesnet.cz iburst
server tak.cesnet.cz iburst
driftfile /etc/chrony.drift
deny all
rtconutc
rtcsync
EOF

#sync time after each reboot
cat > /etc/rc.local <<EOF
#!/bin/sh -e
#set time via ntpdate right after reboot
ntpdate -u -b ntp.nic.cz >> /var/log/rc.local.log 2>&1
exit 0
EOF
