# Search AirBnB
How many events for Apartments in Brooklyn with a price higher than 40?

```splunk
index=airbnb Neighbourhood=Brooklyn "Property Type"=Apartment | where Price > 40
```

Or

```splunk
source="airbnb.csv" index="main" Neighbourhood=Brooklyn "Property Type"=Apartment | where Price > 40
```

What about Bronx?

```splunk
index=airbnb Neighbourhood=Bronx "Property Type"=Apartment | where Price > 40
```

Or

```splunk
source="airbnb.csv" index="main" Neighbourhood=Bronx "Property Type"=Apartment | where Price > 40
```

## Finding the Latest Events
Upload sampledata.zip data in Splunk.

## Problem (1)
You need to find the latest event for each unique field value. For example, when was the last time each user logged in?

## Solution (1)
At first, you might be tempted to use the transaction or stats command. For example, this search returns, for each unique user, the first value seen for each field:

```splunk
source="Sampledata.zip:*" host="sampledata" | stats first(*) by user
```

The proper way to do that is with the dedup command:

```splunk
… | dedup user
```

### Variations
If you want to get the oldest (not the newest) event with a unique user, use the sortby clause of the dedup command:

```splunk
… | dedup user sortby + _time
```

## Search for recent earthquakes in and around Hawaii
Create a table with data of earthquakes in California with table name as “Earthquake_Usage” with fields as time, place, mag, depth using a CSV file. The table command returns a table that is formed by only the fields that you specify in the arguments. You can download a current CSV file from the [USGS Earthquake Feeds](https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv) and add it as an input to your Splunk deployment.

1) Search for recent earthquakes in and around Hawaii and display only the time of the quake (Datetime), where it occurred (Region), and the quake's magnitude (Magnitude) and depth (Depth).

```splunk
place=*California index="earthquakes" | table time, place, mag, depth
```

2) Create a table with data of earthquake in California with table name as “Earthquake_Usage” with fields as time, place, lat*, lon* mag, depth using CSV file.  Also change the name of lat and lon fields to latitude and longitude respectively.

Show the date, time, coordinates, and magnitude of each recent earthquake in Northern California.

```splunk
place=*California index="earthquakes" | rename latitude as lat longitude as lon | table time, place, lat*, lon*, mag
```

## Return the 20 most common values for a field
Upload the access log files [here](https://drive.google.com/file/d/1UHmGW9pRCduUlf37gW-SveBMMDAGrQpy/view?usp=sharing)

You'll need to extract some fields like referrer, referrer_domain, and useragent. You can use [this page](https://httpd.apache.org/docs/1.3/logs.html) as a reference to know where each field is located at, or you can use the following regular expression when extracting new fields (you can go back to the lab we did previously for extracting new fields):

```splunk
^[^ \n]* (?P<referrer_domain>[^ ]+)(?:[^"\n]*"){5}(?P<referrer>[^"]+)"\s+"(?P<useragent>[^"]+)(?:[^ \n]* ){3}(?P<bytes>\d+)
```

Search the access logs and return 20 most common values for a field

**Example 1: Return the 20 most common values for a field**
This search returns the 20 most common values of the "referer" field. The results show the number of events (count) that have that a count of referer, and the percent that each referer is of the total number of events.

```splunk
sourcetype=access_* | top limit=20 referrer
```

## Return top values for one field organized by another field
Search the access logs and return top values for one field organized by another field

**Example 2: Return top values for one field organized by another field**
This search returns the top "action" values for each "referer_domain".

```splunk
sourcetype=access_* | top action by referer_domain
```

Because a limit is not specified, this returns all the combinations of values for "action" and "referer_domain" as well as the counts and percentages.

## Specifying multiple aggregations and multiple by-clause fields
Upload the access.log file

Search the access logs and specify multiple aggregations & multiple by-clause fields

## Problem (2)
Specifying multiple aggregations and multiple by-clause fields

## Solution (2)
This search organizes the incoming search results into groups based on the combination of host and sourcetype. It returns the sum of the bytes in the Sum of bytes field and the average bytes in the Average field for each group. If there are two distinct hosts and two distinct sourcetypes, the search will produce results similar to this:

```splunk
sourcetype=access_* | stats sum(bytes) AS "Sum of bytes", avg(bytes) AS Average BY host, sourcetype
```

## Search without a subsearch
Search for clientip from access.log file with status as 200 and action as checkout with following parameters:

- Where top limit is 1
- Where clientip is 95.55.51.230 and then apply stats on count, dc & value on product_name

You need to extract the clientip, status, action, and product_name fields.

## Solution (3)

```splunk
sourcetype=access_* status=200 action=checkout | top clientip
```

```splunk
sourcetype=access_* status=200 action=checkout clientip=95.55.51.230 | stats count, dc(product_name), values(product_name) by clientip
```

```splunk
sourcetype=access_* status=200 action=checkout [search sourcetype=access_* status=200 action=checkout | top limit=1 clientip | table clientip] | stats count, dc(product_name), values(product_name) by clientip
```

## Parallel Coordinates Query
Search for fat and calories along with stats count on groups from nutrients.csv dataset.

Load nutrients.csv file into Splunk

Here is a parallel coordinates query tracking fat and calorie information for different food groups.

```splunk
source="nutrients.csv" | head 2500  | stats count by group, "fat _g", calories
```

The query generates a table with columns for the food group, additional dimensions, and the count.

## eval Basic Examples
For this lab, you can use any data set you've uploaded previously, you simply need to use the eval tool and:

- Create a new field that contains the result of a calculation
- Use the if function to determine the values placed in the status field. Also, create a field called status in each event. You can use the `if` condition you want, the idea is simply that you practice the command.

## Examples
Create a new field called velocity in each event. Calculate the velocity by dividing the values in the distance field by the values in the time field. You might not have the distance and time fields, so use any other field, the idea is simply to give it a try to the command, not the result.

```splunk
... | eval velocity=distance/time
```

Using the if function, set the value in the status field to OK if the error value is 200. Otherwise set the status value to Error.

```splunk
... | eval status = if(status == 200, "OK", "Error")
```

## Dealing with Time
Upload the userdataset.csv file and then search for _time & usr. Also use the eval tool to:

- Convert _time data into %I:%M %p format.
- Convert _time data into %d %B,%I:%M %p format.

## Time Conversion
A Simple scenario that's going to have a timestamp and a user name (You might need to adapt the below queries depending on how you uploaded the data into Splunk).

```splunk
host="userdataset" usr=* | table _time usr
```

Now see the 12-hour marker and the minute marker and also see the AM or PM marker

```splunk
host="userdataset" usr=* | eval timestamp=strftime(_time,"%I:%M %p") | table timestamp
```

Bring the date before time information

```splunk
host="userdataset" usr=* | eval timestamp=strftime(_time,"%d %B,%I:%M %p") | table timestamp usr
```
