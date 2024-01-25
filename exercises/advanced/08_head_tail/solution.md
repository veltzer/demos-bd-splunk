# Solution to the `head` and `tail` exercise

```splunk
index="web" | stats count by clientip | sort -count | head 5 | tail 1
```
