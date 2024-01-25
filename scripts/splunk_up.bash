#!/bin/bash -e

# References:
# - https://hub.docker.com/r/splunk/splunk#quickstart
# - https://stackoverflow.com/questions/38576337/how-to-execute-a-bash-command-only-if-a-docker-container-with-a-given-name-does

# if splunk is already running - stop
if [ "$(docker ps -q -f name=splunk)" ]
then
	echo "splunk is already running"
	exit 1
else
	echo "splunk is not running, running it"
fi
# cleanup old container by that same name if exists (this is essential to free up the name)
docker rm splunk > /dev/null || true
docker run\
	--detach\
	--publish 8000:8000\
	--env "SPLUNK_START_ARGS=--accept-license"\
	--env "SPLUNK_PASSWORD=password"\
	--name "splunk"\
	"splunk/splunk:latest" > /dev/null
