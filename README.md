# Audio Normalizer &middot; [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Version](https://img.shields.io/badge/version-1.0-blue.svg)](https://semver.org)

Audio Normalizer is a Bash script that automatically normalizes the volume of MP3 files in a specified directory.

## :star2: Main Features

- Watches a specified directory for new MP3 files
- Automatically normalizes the volume of new MP3 files
- Sends desktop notifications in English or Spanish based on the user's language settings
- Uses "normalize" folder for English users and "normalizar" for Spanish users
- Keeps track of processed files to avoid redundant operations

## :gear: Installation

1. Clone this repository:
   ```
   git clone https://github.com/Serverket/audio-normalizer.git
   cd audio-normalizer
   ```

2. Install dependencies:
   ```
   sudo apt update
   sudo apt install inotify-tools mp3gain libnotify-bin
   ```

3. Make the script executable:
   ```
   chmod +x audio-normalizer.sh
   ```

## :shipit: Usage

1. Run the script:
   ```
   ./audio-normalizer.sh
   ```

2. The script will create a directory called "normalize" (for English users) or "normalizar" (for Spanish users) in your home folder.

3. Place MP3 files in the created directory. The script will automatically process new files.

For detailed installation and usage instructions, including how to set up the script as a system service, please refer to the [INSTALL.md](INSTALL.md) file.

## :brain: Acknowledgements

*"Whoever loves discipline loves knowledge, but whoever hates correction is stupid."*

## :scroll: License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.