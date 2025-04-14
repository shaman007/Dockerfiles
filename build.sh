#!/bin/bash
set -euo pipefail

PATH=/root/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Pull latest code
git pull

# Get timestamp
timestamp=$(date +"%Y-%m-%d-%H%M")

# Define variables
apps=( $(ls -la | grep '^d' | grep -v '\.\{1,2\}$' | awk '{ print $9 }') )
registry="harbor.andreybondarenko.com"

# Loop through all app directories
for app in "${apps[@]}"; do
  echo "-------- BUILDING $registry/library/$app:latest and :$timestamp --------"
  cd "$app"

  docker buildx build --platform linux/amd64,linux/arm64 \
    -t "$registry/library/$app:latest" \
    -t "$registry/library/$app:$timestamp" \
    --push .

  cd ..
done
