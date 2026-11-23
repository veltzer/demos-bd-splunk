#!/bin/bash -e

# References:
# - https://stackoverflow.com/questions/38576337/how-to-execute-a-bash-command-only-if-a-docker-container-with-a-given-name-does

splunk_container=$(docker ps -q -f name=splunk)
if [[ -n "${splunk_container}" ]]
then
	echo "splunk is running"
else
	echo "splunk is not running"
fi
