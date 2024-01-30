# Solution

```splunk
index="web" | search date_month="may" | stats count(_raw) by action
```

Call the macro `events_by_action(1)` and add a parameters `month`

```splunk
index="web" | search date_month="$month$" | stats count(_raw) by action
```
