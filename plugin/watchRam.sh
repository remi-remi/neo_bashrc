#!/bin/bash
# Plugin: watchRam
# Description: Monitors the memory usage of a process and plays a sound if the usage exceeds a specified threshold.

# Path to audio files
WATCHRAM_AUDIO_DIR="$(dirname "${BASH_SOURCE[0]}")/audio"
WATCHRAM_FAIL_FILE="$WATCHRAM_AUDIO_DIR/fail.wav"

# Checking for prerequisites when sourcing
_watchRam_check_requirements() {
    local missing_items=()

    # Check if the 'play' command is available
    if ! command -v play >/dev/null 2>&1; then
        missing_items+=("Command 'play' not found (install 'sox').")
    fi

    # Check if the necessary audio file exists
    if [ ! -f "$WATCHRAM_FAIL_FILE" ]; then
        missing_items+=("Missing failure audio file: $WATCHRAM_FAIL_FILE")
    fi

    # Display warnings if any items are missing
    if [ ${#missing_items[@]} -ne 0 ]; then
        echo "⚠️ Plugin watchRam: Issues detected!"
        for item in "${missing_items[@]}"; do
            echo "  - $item"
        done
        echo "⚠️ The plugin will not work properly."
    fi
}

# Main function that checks the memory usage of the process
watchRam() {
    # Check if the correct number of arguments are provided
    if [ $# -ne 2 ]; then
        echo "⚠️ Error: You must provide two arguments:"
        echo "  1. PID of the process to monitor"
        echo "  2. Memory usage threshold (in KB) (1MB = 1000KB)"
        return 1
    fi

    # Get the arguments
    local PID=$1
    local THRESHOLD=$2

    # Check if the PID is a valid integer
    if ! [[ "$PID" =~ ^[0-9]+$ ]]; then
        echo "⚠️ Error: The PID must be an integer."
        return 1
    fi

    # Check if the threshold is a valid integer
    if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]]; then
        echo "⚠️ Error: The threshold must be an integer in KB."
        return 1
    fi

    # Run prerequisite checks
    _watchRam_check_requirements

    # Monitor the memory usage of the process
    while true; do
        if ps -p $PID > /dev/null; then
            # Get the memory usage (in KB) via the RSS field
            MEM_USAGE=$(ps -o rss= -p $PID)
            echo "$PID is using $MEM_USAGE KB"

            # If the memory usage exceeds the threshold, play the alert sound
            if [[ $MEM_USAGE -gt $THRESHOLD ]]; then
                echo "⚠️ Memory usage of $PID exceeds the threshold of $THRESHOLD KB. Playing alert sound."
                play "$WATCHRAM_FAIL_FILE" >/dev/null 2>&1
            fi
        fi
        sleep 60
    done
}

# Export the function to make it available in the shell
export -f watchRam

