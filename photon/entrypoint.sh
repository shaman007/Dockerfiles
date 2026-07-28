#!/usr/bin/env bash
set -euo pipefail

if [ -d /photon/photon_data/elasticsearch ]; then
    echo "Legacy pre-1.0 Photon database detected; replace the volume with a Photon 1.x database dump" >&2
    exit 1
fi

# Download the current Photon 1.x OpenSearch index when the volume is empty.
if [ ! -d /photon/photon_data ] || [ -z "$(find /photon/photon_data -mindepth 1 -print -quit)" ]; then
    echo "Downloading search index"

    # Let graphhopper know where the traffic is coming from
    USER_AGENT="docker: tonsnoei/photon-geocoder"
    wget --user-agent="$USER_AGENT" -O - \
        https://download1.graphhopper.com/public/photon-db-planet-1.0-latest.tar.bz2 \
        | bzip2 -cd | tar x
fi

# Start Photon if the index exists.
if [ -d /photon/photon_data ] && [ -n "$(find /photon/photon_data -mindepth 1 -print -quit)" ]; then
    echo "Start photon"
    exec java -jar photon.jar serve "$@"
else
    echo "Could not start photon, the search index could not be found"
    exit 1
fi
