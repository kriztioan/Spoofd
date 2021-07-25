#!/usr/bin/env /bin/bash
###
#  @file   spoofd.bash
#  @brief  MAC Spoof
#  @author KrizTioaN (christiaanboersma@hotmail.com)
#  @date   2021-07-25
#  @note   BSD-3 licensed
#
###############################################

# Support folder location

SUPPORT_FOLDER="$HOME/Library/Application Support/Spoofd"

# Source variables

source "$SUPPORT_FOLDER/etc/config"

# Source auxilary functions

source "$SUPPORT_FOLDER/lib/aux.bash"

function main {

	# Starting

	message "starting Spoofd (PID $$)"

	# Check if WiFi is on

	STATUS=$(networksetup -getairportpower "$INTERFACE" | awk '/Wi-Fi Power \('"$INTERFACE"'\):/{print $4}')

	message "$INTERFACE is $STATUS"

	if [ $STATUS != "On" ]; then

		message "$INTERFACE needs to be on in order to change MAC"

		return
	fi

	# Current MAC

	CURRENT=$(ifconfig $INTERFACE ether | awk '/ether/{print $2}')

	message "current MAC on $INTERFACE is $CURRENT"

	# Spoof needed?

	SPOOF=0

	SSIDS=($(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s | awk '{print $1}'))

	TRIES=0

	while [ ${#SSIDS[@]} -eq 1 ]; do

		if [ $TRIES -eq $MAX_TRIES ]; then

			message "given up finding SSIDs after $MAX_TRIES tries"

			return
		fi

		SSIDS=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s | awk '{print $1}')

		sleep 2
	done

	for x in ${SSIDS[@]}; do

		if [ $x == $TRIGGER ]; then

			SPOOF=1

			break
		fi
	done

	message "trigger on $INTERFACE is $SPOOF"

	# Spoof needed

	if [ $SPOOF -eq 1 ]; then

		if [ $CURRENT == $SOFTWARE ]; then

			message "MAC on $INTERFACE already spoofed ($CURRENT)"
		else

			message "requesting elevated privileges"

			osascript -e "do shell script \"ifconfig $INTERFACE ether $SOFTWARE\" with administrator privileges"

			if [ $? -eq 1 ]; then

				message "canceled by user or timed out"

				return
			fi

			message "sleeping 2 seconds for changes to take effect"

			sleep 2

			message "spoofed MAC on $INTERFACE ($SOFTWARE)"
		fi

		MYSSID=$(networksetup -getairportnetwork $INTERFACE | awk '{split($0,x," "); print x[4]}')

		if [ $MYSSID != $TRIGGER ]; then

			message "connecting to $TRIGGER on $INTERFACE"

			networksetup -setairportnetwork $INTERFACE $TRIGGER
		fi
	fi

	# No spoof needed

	if [ $SPOOF -eq 0 ]; then

		if [ $CURRENT == $HARDWARE ]; then

			message "hardware MAC already in use on $INTERFACE ($CURRENT)"
		else

			message "requesting elevated privileges"

			osascript -e "do shell script \"ifconfig $INTERFACE ether $HARDWARE\" with administrator privileges"

			if [ $? -eq 1 ]; then

				message "canceled by user or timed out"

				return
			fi

			message "restored hardware MAC on $INTERFACE ($HARDWARE)"
		fi
	fi
}

main >> "$HOME/Library/Logs/$LOG_FILE" 2>&1
