# Using Lookups
This time, you'll create lookups that you can later use when searching events.

## **Make sure you save the searches. You'll need them later**

## Upload Data
Let's upload more data again. This time, upload the data from the **sub-est2016_all.csv** file.

## Upload the Lookups Data
Let's upload the lookups CSV data manually to Splunk.

- Download the "States" file (**sub-est2016_all_states.csv**), **THIS IS A DIFFERENT FILE** from the previous task.
- Go to "Settings" and click on "Lookups" under "Knowledge"
- Click "+ Add new" in the "Lookup table files" section
- Choose the file you just downloaded and extracted
- Type a name for the name of the new lookup table, e.g., states.csv
- Click on "Save"
- Change the "Permissions" of the table to "All apps." You'll find the option in the "Sharing" column in the list of lookup table files (the screen that appears after you saved the file)

## Create a Lookup Definition
Now you need to define the information in the lookup table file and tell Splunk how that information is related to fields in events.

- Go to "Settings" and click on "Lookups" under "Knowledge"
- Click on "Lookup definitions" and then click on "New Lookup Definition"
- Type a name, like `states_lookup`
- Choose the "states.csv" lookup file you just uploaded
- Click on "Save"
- Change the "Permissions" of the table to "All apps." You'll find the option in the "Sharing" column in the list of lookup table files (the screen that appears after you saved the file)

You can confirm that the lookup works by using the following command:\

```splunk
source="sub-est2016_all.csv" host="splunk-di" sourcetype="csv" | lookup states.csv STATE OUTPUT STNAME | where STNAME="Illinois"
```

## Lookup Automatically
Instead of having to manually use the lookup table, you can configure it when you want to apply a field lookup to the events when searching.

- Go to "Settings" and click on "Lookups" under "Knowledge"
- Click "+ Add new" in the "Automatic lookups" section
- Type a name for the lookup, like `autolookup_states`
- Choose the lookup table definition you just created
- In the empty text box for "Apply to," select "source" and type `sub-est2016_all.csv`
- For "Lookup input fields," type "STATE" in both text boxes
- For "Lookup output fields," specify the fields that you'd like to display in the search results:
    - Type `STNAME` (field in states.csv) and `STNAME` in the text boxes
- Click on "Save"
- Go to the lookups page again. Click on the lookup you just created and change the permissions. It shouldn't be private; it should have read access for "Everyone" and be available for any app.

## Search Using the Lookups
Finally, let's use the lookups when searching events.

- Go back to the search page
- Search for the `source="sub-est2016_all.csv` events from `All time`
- Scroll through the "Interesting Fields" and look for the "STNAME" field
- Click the "STNAME" link
- Click "Yes" for the "Selected" option to move this field to the list of selected fields
- Close the dialog box
- Run the searches below and ask "What data is each search returning?"

```splunk
source="sub-est2016_all.csv" |stats values(STNAME) AS STNAME BY STATE
```

```splunk
source="sub-est2016_all.csv" STNAME=Illinois | top limit=20 NAME
```
