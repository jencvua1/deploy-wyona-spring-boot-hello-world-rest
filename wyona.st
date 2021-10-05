#!/bin/sh

SCRIPTNAME=~/bin/wyona.st
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

[ -x $JAVA_HOME ] || exit 0

case "$1" in
	start)
	if [ -r /opt/wyona/hello-world-webapp-1.0.0-SNAPSHOT.war ]; then
	sudo su wyona - -c "screen -dmS hellow java -jar /opt/wyona/hello-world-webapp-1.0.0-SNAPSHOT.war"
	fi
	;;
	stop)
	sudo su wyona - -c "screen -S hellow -X quit"
	;;
	restart)
	pidof SCREEN 1>/dev/null && sudo su wyona - -c "screen -S hellow -X quit"
	sudo su wyona - -c "screen -dmS hellow java -jar /opt/wyona/hello-world-webapp-1.0.0-SNAPSHOT.war"
	;;
	force-reload|status)
	;;
  *)
	echo "Usage: $SCRIPTNAME {start|stop}" >&2
	exit 3
	;;
esac

