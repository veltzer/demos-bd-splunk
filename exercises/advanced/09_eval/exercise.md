# Eval exercises

* Use the `access_combined` log we have been using.

* Look at the `bytes` field. It looks like splunk got it wrong as it is the result of the query so rename it
    to `status` and rename `status` to `state`

* Count the number of times the status == 200 using `eval` and `stats count`

* Create a new field called success which is boolean and which is true if and only if status=200

* Calculate length of sessions using `JSESSIONID` just like in the slides. Use `eval`, `tostring`
