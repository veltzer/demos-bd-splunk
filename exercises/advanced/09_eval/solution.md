# Solution

```splunk
index="web" | rename status as state | rename bytes as status | table _time, status, state

index="web" | rename status as state | rename bytes as status | stats count(eval(status=200)) as success | table _time, success

index="web" | rename status as state | rename bytes as status | eval success=if(status==200, "true", "false") | table _time, success

index="web" | stats range(_time) as sessionTime by JSESSIONID | eval duration=tostring(sessionTime, "duration") | table JSESSIONID, duration

with rounding of sessionTime:
index="web" | stats range(_time) as sessionTime by JSESSIONID | eval sessionTime=round(sessionTime, 0) | eval duration=tostring(sessionTime, "duration")
```
