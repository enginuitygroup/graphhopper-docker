#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: download-data [data-path]"
  echo "data-path: The path and filename of the GeoFabrik-hosted OSM data file. Example: /north-america/canada/ontario-latest"
  exit 1
fi

wget -O /data/data.osm.pbf http://download.geofabrik.de/$1.osm.pbf