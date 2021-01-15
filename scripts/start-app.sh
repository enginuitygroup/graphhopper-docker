#!/usr/bin/env bash

if [ -z "${JAVA_OPTS}" ]; then
	JAVA_OPTS="$JAVA_OPTS -Xms64m -Xmx1024m -Djava.net.preferIPv4Stack=true"
	JAVA_OPTS="$JAVA_OPTS -server -Djava.awt.headless=true -Xconcurrentio"
	echo "Setting default JAVA_OPTS"
fi

$JAVA_HOME/bin/java $JAVA_OPTS -Ddw.graphhopper.datareader.file="/data/data.osm.pbf" -jar $APP_PATH/graphhopper-web.jar server $APP_PATH/config.yml