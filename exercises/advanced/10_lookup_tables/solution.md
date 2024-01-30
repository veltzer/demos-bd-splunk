# Solution

Query to check that the lookup works fine:

``splunk
index="web" | stats values(product_name) as product_name| lookup product_name_to_price_new.csv product_name OUTPUT price
```

And the solution is:

```splunk
index="web" | lookup product_name_to_price_new.csv product_name OUTPUT price | stats sum(price) by date_month
```
