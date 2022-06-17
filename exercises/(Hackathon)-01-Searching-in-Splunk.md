# Census Data
Using the data you uploaded previously (cbg_patterns.csv), answer the following questions:

**HINT**: There's no "brand" field, so use the "top_brands" field. I know, it's not a typical field because there are events that has more than one value (an array), but that's the complexity.

- What's the top brand in 2018? (use the "top_brands" field)
- How many events are for October?
- How many events are in 2017?
- How many events are that have the `Cricket Wireless` brand as a top brand (top_brand field)? Inspect how the data is being stored for the brand field. You'll need to escape the characters and be specific in the search term. Spoiler alert: the number is greater than 1,000 and lower than 3,500.
- How many events are for the brand `McDonalds`?

If you want, you can save each search. We'll talk about that later. But just in case you finish early...;)

# Google Play Store
Let's upload more data again. This time, upload the data from Google Play Store Apps(google-play-store-apps.zip) **DON'T EXTRACT THE ZIP, UPLOAD THE ZIP AS IT IS**.

- What's the third most popular category?
- What are the top three apps with a rating of five in August, 2018?
- How many apps exist for Android version `5.0 and up`? (You might need to look closely at the list of fields available)
- How many installations (there's a field for this) have had the `Bowmasters` app? (You might need to look closely at the list of fields available)
- How many **paid** apps with more than "500,000+" installations exist? Give me the first three order alphabetically.
- What's the most common sentiment for the `Facebook` app? Positive or negative?
- What's the rating value for the `Twitter` app?

# Solution
## Census Data
- What's the top brand in 2018? 
`source="cbg_patterns.csv" host="splunk" index="cbg" sourcetype="csv" date_year="2018"| top limit=20 top_brands`
`["United States Postal Service (USPS)"]`

- How many events are for October?
`source="cbg_patterns.csv" host="splunk" index="cbg" sourcetype="csv" date_month=october`
`65,854`

- How many events are in 2017?
`source="cbg_patterns.csv" host="splunk" index="cbg" sourcetype="csv" date_year=2017`
`1,262`

- How many events are that have the `Cricket Wireless` brand as a top brand (top_brand field)? Inspect how the data is being stored for the brand field. You'll need to escape the characters and be specific in the search term. Spoiler alert: the number is greater than 1,000 and lower than 3,500.
`source="cbg_patterns.csv" host="splunk" index="cbg" sourcetype="csv" top_brands="*Cricket Wireless*"`
`3,293`

- How many events are for the brand `McDonalds`?
`source="cbg_patterns.csv" host="splunk" index="cbg" sourcetype="csv" top_brands="*McDonalds*"`
`4,082`

## Google Play Store
- What's the third most popular category?
`source="google-play-store-apps.zip:*" host="splunk" index="playstore"| top limit=3 Category`
`TOOLS`

- What are the top three apps with a rating of five in August, 2018?
`source="google-play-store-apps.zip:*" host="splunk" index="playstore" date_month=august date_year=2018 Rating="5.0"
| top limit=3 App`
`Sway Medical, BP Journal - Blood Pressure Diary, 420 BZ Budeze Delivery`

- How many apps exist for Android version `5.0 and up`? (You might need to look closely at the list of fields available)
`source="google-play-store-apps.zip:*" host="splunk" index="playstore" "Android Ver"="5.0 and up" | dedup App`
`512`

- How many installations have had the `Bowmasters` app? 
`source="google-play-store-apps.zip:*" host="splunk" index="playstore" App="Bowmasters" Installs=* | dedup Installs | table Installs`
`50,000,000+`

- What are the **paid** apps with "500,000+" installations? Give me the first three ordered:
`source="google-play-store-apps.zip:*" host="splunk" index="playstore" Installs="500,000+" Type=Paid | dedup App | sort App | table App`
`ADWLauncher 1 EX, Assassin's Creed Identity, CamScanner (License)`

- What's the most common sentiment for the `Facebook` app? Positive or negative?
`source="google-play-store-apps.zip:*" host="splunk" index="playstore" App="Facebook" | top Sentiment`
`Negative`

- What's the rating value for the `Twitter` app?
`source="google-play-store-apps.zip:*" host="splunk" index="playstore" App="Twitter" | table Rating | dedup Rating`
`4.3`