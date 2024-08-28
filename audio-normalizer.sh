#!/bin/bash

# Detect user language
LANG=$(echo $LANG | cut -d_ -f1)

# Set folder name and notification messages based on language
if [ "$LANG" = "es" ]; then
    FOLDER_NAME="normalizar"
    START_MSG="Procesando"
    START_BODY="El archivo %s está siendo procesado."
    FINISH_MSG="Finalizado"
    FINISH_BODY="El archivo %s ha sido normalizado."
else
    FOLDER_NAME="normalize"
    START_MSG="Processing"
    START_BODY="The file %s is being processed."
    FINISH_MSG="Finished"
    FINISH_BODY="The file %s has been normalized."
fi

# Get the directory to watch
WATCH_DIR="$HOME/$FOLDER_NAME"

# Create a temporary file to keep track of processed files
PROCESSED_FILES="/tmp/processed_mp3_files.txt"

# Ensure the processed files list exists
touch "$PROCESSED_FILES"

# Ensure the watch directory exists
mkdir -p "$WATCH_DIR"

# Function to send notifications
send_notification() {
    local title="$1"
    local message="$2"
    
    if [ "$XDG_CURRENT_DESKTOP" = "KDE" ] && command -v kdialog &> /dev/null; then
        kdialog --title "$title" --passivepopup "$message" 5
    elif command -v notify-send &> /dev/null; then
        notify-send "$title" "$message"
    elif command -v zenity &> /dev/null; then
        zenity --notification --text="$title: $message"
    elif [ "$XDG_CURRENT_DESKTOP" = "XFCE" ] && command -v xfce4-notifyd-config &> /dev/null; then
        xfce4-notifyd-config "$title" "$message"
    elif command -v osascript &> /dev/null; then
        # For macOS
        osascript -e "display notification \"$message\" with title \"$title\""
    else
        echo "$title: $message"
    fi
}

inotifywait -m -e close_write,moved_to --format '%f' "$WATCH_DIR" | while read FILE
do
    # Check if the file is an mp3
    if [[ "$FILE" == *.mp3 ]]; then
        # Check if the file has already been processed
        if ! grep -Fxq "$FILE" "$PROCESSED_FILES"; then
            # Notify that processing is starting
            send_notification "$START_MSG" "$(printf "$START_BODY" "$FILE")"
            
            # Wait a moment for any other write operations to complete
            sleep 2
            
            # Check if the file exists before processing
            if [[ -f "${WATCH_DIR}/${FILE}" ]]; then
                # Normalize the MP3 file
                mp3gain -r "${WATCH_DIR}/${FILE}"
                
                # Notify that processing is finished
                send_notification "$FINISH_MSG" "$(printf "$FINISH_BODY" "$FILE")"
                
                # Add the file to the processed list
                echo "$FILE" >> "$PROCESSED_FILES"
            fi
        fi
    fi
done