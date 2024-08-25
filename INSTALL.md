# Installation and Setup Guide

## Prerequisites

- A Linux system with Bash
- `inotify-tools`, `mp3gain`, and `libnotify-bin` packages

## Installation Steps

1. Install the required packages:
   ```
   sudo apt update
   sudo apt install inotify-tools mp3gain libnotify-bin
   ```

2. Create the directory and move the script:
   ```
   sudo mkdir -p /opt/audio-normalizer
   sudo mv audio-normalizer.sh /opt/audio-normalizer/
   sudo chmod +x /opt/audio-normalizer/audio-normalizer.sh
   ```

3. The script will automatically create a "normalize" or "normalizar" directory in the user's home folder based on their language settings.

## Setting up as a System Service

### For systemd:

1. Create a systemd service file:
   ```
   sudo nano /etc/systemd/system/audio-normalizer.service
   ```

2. Paste the content from the `audio-normalizer.service` file in this repository.

3. Reload systemd, enable and start the service:
   ```
   sudo systemctl daemon-reload
   sudo systemctl enable audio-normalizer.service
   sudo systemctl start audio-normalizer.service
   ```

### For SysV init:

1. Copy the init script:
   ```
   sudo cp audio-normalizer.init /etc/init.d/audio-normalizer
   ```

2. Make the init script executable:
   ```
   sudo chmod +x /etc/init.d/audio-normalizer
   ```

3. Update the system's init script links:
   ```
   sudo update-rc.d audio-normalizer defaults
   ```

4. Start the service:
   ```
   sudo service audio-normalizer start
   ```

### For OpenRC:

1. Copy the service file:
   ```
   sudo cp audio-normalizer.openrc /etc/init.d/audio-normalizer
   ```

2. Make the service file executable:
   ```
   sudo chmod +x /etc/init.d/audio-normalizer
   ```

3. Add the service to the default runlevel:
   ```
   sudo rc-update add audio-normalizer default
   ```

4. Start the service:
   ```
   sudo rc-service audio-normalizer start
   ```

## Managing the Service

### For systemd:

- Start: `sudo systemctl start audio-normalizer.service`
- Stop: `sudo systemctl stop audio-normalizer.service`
- Restart: `sudo systemctl restart audio-normalizer.service`
- Check status: `sudo systemctl status audio-normalizer.service`

### For SysV init:

- Start: `sudo service audio-normalizer start`
- Stop: `sudo service audio-normalizer stop`
- Restart: `sudo service audio-normalizer restart`
- Check status: `sudo service audio-normalizer status`

### For OpenRC:

- Start: `sudo rc-service audio-normalizer start`
- Stop: `sudo rc-service audio-normalizer stop`
- Restart: `sudo rc-service audio-normalizer restart`
- Check status: `sudo rc-service audio-normalizer status`

The service will start automatically on system boot and watch the appropriate directory for new MP3 files to process.