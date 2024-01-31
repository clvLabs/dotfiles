#!/bin/bash
REMMINA_CFG=/home/tony/.remmina/group_rdp_alkamel-dev-laptop-taguilar_192-168-1-191.remmina
NEW_IP=${1}

echo "Setting 192.168.1.${NEW_IP} as new IP for aks-dev-laptop in remmina"

sed -i "s/^server=.*/server=192.168.1.${NEW_IP}/" ${REMMINA_CFG}
