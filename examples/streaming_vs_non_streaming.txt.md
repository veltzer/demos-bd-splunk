index=web | status=200 | dedup | fields ...

All commands here are "streaming" command.

index=[name] | cmd1 | cmd2 | cmd3

Splunk does have to finish cmd1 in order to start working on cmd2

index=[name] | cmd1 | sort 5 | cmd2 | cmd3

In this example we CANNOT START CMD2 AT ALL (for any line!) until cmd1 and sort are completely DONE!
