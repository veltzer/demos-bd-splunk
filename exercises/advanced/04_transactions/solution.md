# Solution

```splunk
index="web" | transaction JSESSIONID maxspan=4h startswith=eval(action="add") endswith=eval(action="checkout") | stats avg(duration)
```
