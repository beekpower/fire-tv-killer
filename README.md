# FireTV Killer

Key Events:
https://gist.github.com/arjunv/2bbcca9a1a1c127749f8dcb6d36fb0bc

## Overview
`run.sh` is a Bash script designed to automate the sending of key events to an Android device over a network. It specifically checks if the device is awake and sends a power key event (keyevent 26) if so. The script operates at random intervals which are configurable to suit user preferences.

## Dependencies
This script requires the following dependencies to be installed on your Linux system:

- **Bash**: Bash is typically pre-installed on most Linux distributions and is used to execute the script.

- **Android Debug Bridge (adb)**: adb is a versatile command-line tool that allows you to communicate with an Android device for debugging and other purposes.

### Installing adb
To install adb on a Debian-based Linux distribution like Ubuntu, use the following commands in your terminal:

```bash
sudo apt update
sudo apt install adb
adb connect 192.168.x.x:5555
```

## Configuration
To get started with the script, you need to configure several constants defined at the top of the script. These constants include the IP address of the device and the minimum and maximum delay between commands.

### Constants
- **DEVICE_IP**: IP address and port of your Android device. Default is `192.168.5.70:5555`.
- **MIN_DELAY**: Minimum delay in minutes before the script checks the device state and sends a key event. Default is `1`.
- **MAX_DELAY**: Maximum delay in minutes before the script repeats its check. Default is `10`.

### Modifying Constants
Edit `run.sh` in your preferred text editor to adjust the above constants. Simply replace the existing values with your desired settings:

```bash
DEVICE_IP="your.device.ip.address:port"
MIN_DELAY=your_minimum_delay
MAX_DELAY=your_maximum_delay