#!/bin/bash

PORT=4444

echo "Listening on port $PORT..."

while true; do
    nc -lvnp $PORT
    echo "Connection closed. Restarting listener..."
done
