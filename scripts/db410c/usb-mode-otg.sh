#!/bin/bash

BOOTIMG=${1:-/dev/disk/by-partlabel/boot}
DT_ROOT=`dirname $0`/../..
DBOOTIMG=`which dbootimg`
DBOOTIMG=${DBOOTIMG:-${DT_ROOT}/tools/dbootimg/dbootimg}
DTBTOOL=`which dtbtool`
DTBTOOL=${DTBTOOL:-${DT_ROOT}/tools/dtbtool/dtbtool}

${DBOOTIMG} ${BOOTIMG} -x dtb | ${DTBTOOL} -n usb@78d9000 -s dr_mode="otg" | ${DBOOTIMG} ${BOOTIMG} -u dtb

if [ "$?" -ne 0 ]; then
	echo "Failed to update DTB"
	exit 1
fi

echo "USB OTG enabled, please reboot"
sync
