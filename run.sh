#!/bin/bash

# Constants
DEVICE_IP="192.168.4.28:5555"
MIN_DELAY=2
MAX_DELAY=11

# Function to monitor foreground activity and return home if a specific activity is active
monitor_activity() {
    while true; do
        adb connect $DEVICE_IP

        # Get the current foreground activity
        current_activity=$(adb shell dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp')

        # Check if "device.DeviceActivity" is in the current activity
        if [[ $current_activity == *"device.DeviceActivity"* ]]; then
            echo "device.DeviceActivity is currently active. Going home."
            adb -s $DEVICE_IP shell input keyevent 4
        fi

        # Wait for 100 milliseconds before checking again
        sleep 0.5
    done
}

# Function to send a power key event at random intervals only if the device is awake
manage_power() {
    while true; do
        # Generate a random number within the specified range
        delay=$(($RANDOM % (MAX_DELAY - MIN_DELAY + 1) + MIN_DELAY))
        
        # Print the sleep duration message
        echo "Sleeping for $delay minutes..."

        # Sleep for the number of minutes computed above
        sleep ${delay}m

        adb connect $DEVICE_IP

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
}

# Start monitoring activity in the background
monitor_activity &

# Start managing power in the foreground
manage_power