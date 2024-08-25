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

inotifywait -m -e close_write,moved_to --format '%f' "$WATCH_DIR" | while read FILE
do
    # Check if the file is an mp3
    if [[ "$FILE" == *.mp3 ]]; then
        # Check if the file has already been processed
        if ! grep -Fxq "$FILE" "$PROCESSED_FILES"; then
            # Notify that processing is starting
            notify-send "$START_MSG" "$(printf "$START_BODY" "$FILE")"
            
            # Wait a moment for any other write operations to complete
            sleep 2

            # Check if the file exists before processing
            if [[ -f "${WATCH_DIR}/${FILE}" ]]; then
                # Normalize the MP3 file
                mp3gain -r "${WATCH_DIR}/${FILE}"
                
                # Notify that processing is finished
                notify-send "$FINISH_MSG" "$(printf "$FINISH_BODY" "$FILE")"

                # Add the file to the processed list
                echo "$FILE" >> "$PROCESSED_FILES"
            fi
        fi
    fi
done