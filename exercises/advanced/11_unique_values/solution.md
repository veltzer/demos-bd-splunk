# Solution

```splunk
index="web" | stats values(product_name)
```
