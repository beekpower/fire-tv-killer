#!/bin/bash

# Define the IP address of the Android device (Amazon Fire TV)
device_ip="192.168.5.70"

# Connect to the device via ADB
adb connect $device_ip

# Loop to check the foreground activity every second
while true
do
    # Get the current foreground activity
    current_activity=$(adb shell dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp')

    # Check if "device.DeviceActivity" is in the current activity
    if [[ $current_activity == *"device.DeviceActivity"* ]]; then
      echo "device.DeviceActivity is currently active. Going home."
      adb -s $device_ip shell input keyevent 4
    else
      echo "device.DeviceActivity is not active."
    fi

    # Wait for 1 second before checking again
    sleep 0.1
done
