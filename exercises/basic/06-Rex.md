# Create a statistical report based on search results
Use data you've uploaded from the access.log file to Splunk.

Create a report by request type, URL and status code. Such as How many requests were passed, failed and so on in an hour.

We would need to produce a report by request type, URL and status code.

How many requests were passed, failed and so on in an hour.

Here are a few log event examples:

```splunk
[05/Jun/2018:07:25:03 +0000] "GET /healthcheck.jsp HTTP/1.1" 200 259 0 [a10hm/1.0] [-] inbound-8080-1 [-]
[05/Jun/2018:07:25:03 +0000] "GET /healthcheck.jsp HTTP/1.1" 200 259 0 [a10hm/1.0] [-] inbound-8080-232 [-]
[05/Jun/2018:07:25:06 +0000] "DELETE /appname/account/1.0/records/2222005725 HTTP/1.1" 500 235 392 [Apache-HttpClient/4.3.6.redhat-1 (java 1.5)] [0] inbound-8080-15 [-]
[05/Jun/2018:11:00:01 +0000] "PUT /appname/account/1.0/records/4754600006 HTTP/1.1" 500 249 553 [Apache-HttpClient/4.3.6.redhat-1 (java 1.5)] [198] inbound-8080-119 [-]
```

## Solution

```splunk
index="accesslog"
| rex "\"(?<requestType>\w+)\s(?<url>[^\s]+)\s.*\"\s(?<status>\d+)\s(?<size>\d+)\s(?<time>\d+)"
| stats count(eval(status==200)) as passed count(eval(status!=200)) as failed by requestType url status
```

Regex is helpful in transforming your horrible-looking machine logs into beautiful human-understandable reports and you can create from here dashboards that are easy to understand and use. As you've seen previously, you could extract fields using a regular expression in case you don't want to include it in a search query.

## Using erex, regex, rex
Use erex, regex, rex in Splunk to generate regular expressions by:

* Providing a list of values from the data
* Regex Command Filter
* Extract Fields

Load the data.txt file into Splunk.

Use Splunk to generate regular expressions by providing a list of values from the data.

Execute the below command, it's a really simple example but you can see how the result changes (and the regex as well) if you change the data and how what regex you can use instead by looking at the `Job` menu (`Successfully learned regex. Consider using: | rex "(?i)(?P<months>[^,]+),"`).

```splunk
| makeresults
| eval month_text = "07/02,11/03,13/3,01/03,99/3"
| erex months examples="07/02,01/03" counterexamples="99/3" fromfield=month_text
```

Regex Command Filter Using Regular Expressions. Run the below command to see how two events are being filtered. Do you spot which events are being ignored? Why?

```splunk
index=main | regex _raw = "From:\s+<[[:alnum:]]+@[[:alnum:]]+\.[[:alpha:]]+>"
```

Extract Fields Using Regular Expressions `Search Time … | rex field={what_field} “FrontAnchor(?{characters}+)BackAnchor”`. When you run the below command, notice how in the left panel you see more fields, what are the extra fields you see?

```splunk
index=main | rex field=_raw "From:\s+<(?<from>.*)>\s+To:\s+<(?<to>.*)>\s+"
```

More examples of extracting fields using rex:

```splunk
| makeresults
| eval text = "user_id=bob;search;my_saved_search"
| rex field=text "user_id={1}(?<user>\w+);(?<app_name>\w+);(?<saved_search_name>\w+)"
```

```splunk
| makeresults
| eval credit_card_number = "1234-5678-9101-1213"
| rex field=credit_card_number max_match=0 "(?<digits>\d{4})"
```

```splunk
| makeresults
| eval credit_card_number = "1234-5678-9101-1213"
| rex field=credit_card_number offset_field="new_field" max_match=0 "(?<digits>\d{4})"
```

```splunk
| makeresults
| eval credit_card_number = "1234-5678-9101-1213"
| rex field=credit_card_number mode="sed" "s/(\d{4}-){3}/XXXX-XXXX-XXXX-/g"
```

```splunk
| makeresults
| eval credit_card_number = "1234-5678-9101-1213"
| rex field=credit_card_number mode="sed" "s/(\d{4})/XXXX/4"
```

```splunk
| makeresults
| eval credit_card_number = "1234-5678-9101-1213"
| rex field=credit_card_number mode="sed" "y/1234/XXXX/"
```
