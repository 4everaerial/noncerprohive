#!/usr/bin/env bash
# This code is included in /hive/bin/custom function

[[ -z $CUSTOM_TEMPLATE ]] && echo -e "${YELLOW}CUSTOM_TEMPLATE is empty${NOCOLOR}" && return 1
[[ -z $CUSTOM_URL ]] && echo -e "${YELLOW}CUSTOM_URL is empty${NOCOLOR}" && return 1

CUSTOM_TEMPLATE="${CUSTOM_TEMPLATE//[[:space:]]/}"
CUSTOM_ADDRESS=`echo $CUSTOM_TEMPLATE | cut -d "." -f1`
conf="-a=${CUSTOM_ADDRESS} -s=${CUSTOM_URL} -n=${WORKER_NAME} ${CUSTOM_USER_CONFIG}"


[[ -z $CUSTOM_CONFIG_FILENAME ]] && echo -e "${RED}No CUSTOM_CONFIG_FILENAME is set${NOCOLOR}" && return 1
echo "$conf" > $CUSTOM_CONFIG_FILENAME

