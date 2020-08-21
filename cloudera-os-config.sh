#!/bin/bash
# This Script configures OS based on Cloudera's prerequisities
clear
## Disable Swapiness
sudo sysctl vm.swappiness=1
echo "vm.swappiness = 1" >> /etc/sysctl.conf

## Disable THP
sudo echo "never" > /sys/kernel/mm/transparent_hugepage/defrag
sudo echo "never" > /sys/kernel/mm/transparent_hugepage/enabled
# Enable rc.local service
sudo touch /etc/rc.d/rc.local && chmod +x /etc/rc.d/rc.local
sudo systemctl enable rc-local.service --now

# 
sudo cat <<EOF >> /etc/rc.d/rc.local
echo "never" > /sys/kernel/mm/transparent_hugepage/defrag
echo "never" > /sys/kernel/mm/transparent_hugepage/enabled
EOF
## End
