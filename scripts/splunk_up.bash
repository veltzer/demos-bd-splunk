#!/usr/bin/bash -e

# References:
# - https://hub.docker.com/r/splunk/splunk#quickstart

docker run\
	--detach
	--publish 8000:8000\
	--env "SPLUNK_START_ARGS=--accept-license"\
	--env "SPLUNK_PASSWORD=password"\
	--name "splunk"\
	"splunk/splunk:latest"
