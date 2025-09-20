#!/bin/bash

CONFIG_FILE="/etc/charge-limit.conf"

if [ -z "$1" ]; then
  if [ -f "$CONFIG_FILE" ]; then
    LIMIT=$(cat "$CONFIG_FILE")
  else
    echo "No limit provided and no saved value found."
    exit 1
  fi
else
  LIMIT=$1
  echo "$LIMIT" | sudo tee "$CONFIG_FILE" > /dev/null
fi

if [[ "$LIMIT" =~ ^(60|80|100)$ ]]; then
  echo "$LIMIT" | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
else
  echo "Invalid limit: $LIMIT"
  exit 1
fi

