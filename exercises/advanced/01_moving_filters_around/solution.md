# Solution to moving filters around

```splunk
index="web" | search clientip="29.252.11.76" | sort bytes
index="web" | sort bytes | search clientip="29.252.11.76"
```
