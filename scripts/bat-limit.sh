#!/bin/bash

# Path to the battery threshold file
THRESHOLD_FILE="/sys/class/power_supply/BAT0/charge_control_end_threshold"

# Read the current limit
CURRENT_LIMIT=$(cat "$THRESHOLD_FILE")

# Cycle through 60 -> 80 -> 100 -> 60
case "$CURRENT_LIMIT" in
    60)
        NEW_LIMIT=80
        ;;
    80)
        NEW_LIMIT=100
        ;;
    *)
        NEW_LIMIT=60
        ;;
esac

# Apply the new limit
echo "$NEW_LIMIT" | sudo tee "$THRESHOLD_FILE"
echo "Battery charge limit set to ${NEW_LIMIT}%"
