#!/bin/bash

# Constants
DEVICE_IP="192.168.5.70:5555"
MIN_DELAY=1
MAX_DELAY=1

# This script sends a power key event to an Android device only if it is currently awake.
# It runs at random intervals between MIN_DELAY and MAX_DELAY minutes.

while true; do
    # Generate a random number within the specified range
    delay=$(($RANDOM % (MAX_DELAY - MIN_DELAY + 1) + MIN_DELAY))
    
    # Print the sleep duration message
    echo "Sleeping for $delay minutes..."

    # Sleep for the number of minutes computed above
    sleep ${delay}m

    # Check the wakefulness state of the device
    wakefulness=$(adb -s $DEVICE_IP shell dumpsys power | grep 'mWakefulness=' | cut -d '=' -f 2 | tr -d '\r')

    if [ "$wakefulness" = "Awake" ]; then
        # Device is awake, send the power key event to turn it off
        adb -s $DEVICE_IP shell input keyevent 26
        echo "Device was on. Sent power event."
    else
        echo "Device is off. No power event sent."
    fi
done
