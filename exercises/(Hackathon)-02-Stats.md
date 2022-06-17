Let's use some data from FIFA. Upload the file for soccer rankings(fifa-international-soccer-mens-ranking-1993now.zip).

Present the data as if you were going to build a report.

- What's the average rank number for Spain in 2018?
- What is the average rank number for Germany or Italy in 2000?
- What are the top five countries that had events (logs or records) in 2014?
- List the countries with a new `diff_points` field that includes the difference between `total_points` and `previous_points`. diff_points = total_points - previous_points. What are the top 5?
- What are the min, avg, and max rank numbers for Italy for all time?

## Solution
- What's the average rank number for Spain in 2018?
`source="fifa-international-soccer-mens-ranking-1993now.zip:*" host="splunk" index="fifa" country_full="Spain" | stats avg(rank)`
`5.321678321678322`

- What is the average rank number for Germany or Italy in 2000?
`source="fifa-international-soccer-mens-ranking-1993now.zip:*" host="splunk" index="fifa" country_full="Germany" OR country_full="Italy" | stats avg(rank) as avgrank by country_full`
`Germany = 5.104895104895105 | Italy = 8.353146853146853`

- What are the top five countries that had events (logs or records) in 2014?
`source="fifa-international-soccer-mens-ranking-1993now.zip:*" host="splunk" index="fifa" rank_date="2014*" | top limit=5 country_full`
`Sudan, Zimbabwe, Zambia, Yemen, Wales`

- List the countries with a new `diff_points` field that includes the difference between `total_points` and `previous_points`. diff_points = total_points - previous_points
`source="fifa-international-soccer-mens-ranking-1993now.zip:*" host="splunk" index="fifa" | eval diff_points = total_points - previous_points | stats max(diff_points) by country_full | sort max(diff_points) desc | head 5`
`Netherlands, Argentina, Germany, Equatorial Guinea, Colombia`

- What are the min, avg, and max rank numbers for Italy for all time?
`source="fifa-international-soccer-mens-ranking-1993now.zip:*" host="splunk" index="fifa" country_full="Italy" | stats min(rank), max(rank), avg(rank)`
`min: 1, avg: 8.3531468531468, max: 20`