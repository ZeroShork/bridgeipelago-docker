#!/bin/bash
set -e

# Load env variables from .env file if it exists
if [ -f /bridgeipelago/.env ]; then
  echo "Loading environment from /bridgeipelago/.env"
  export $(grep -v '^#' /bridgeipelago/.env | xargs)
else
  echo "No .env file found at /bridgeipelago/.env"
fi

# Start the app
exec python3 bridgeipelago.py
