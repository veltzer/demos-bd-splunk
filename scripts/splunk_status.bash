#!/usr/bin/bash -e

# References:
# -

if [ "$(docker ps -q -f name=splunk)" ]
then
	echo "splunk is running"
else
	echo "splunk is not running"
fi
