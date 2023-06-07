#!/bin/zsh

CURR_DATE=$(date +%Y%m%d)
LAST_UPDATE_FILE="/home/tony/.config/daily-apt-update-timestamp.txt"
LAST_UPDATE=$(cat ${LAST_UPDATE_FILE} 2>&1 > /dev/null)

echo "Daily apt update"

if [ "${LAST_UPDATE}" = "${CURR_DATE}" ]
then
  echo "Already run today (${CURR_DATE}), skipping..."
  exit 0
fi

apt update

echo "${CURR_DATE}" > "${LAST_UPDATE_FILE}"

