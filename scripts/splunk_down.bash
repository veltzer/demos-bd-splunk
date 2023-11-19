#!/usr/bin/bash -e

# References:
# - https://stackoverflow.com/questions/38576337/how-to-execute-a-bash-command-only-if-a-docker-container-with-a-given-name-does

# check that splunk is running
if [ "$(docker ps -q -f name=splunk)" ]
then
	echo "splunk is up, killing splunk"
	docker kill splunk > /dev/null
else
	echo "splunk is not running"
fi
