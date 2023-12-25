# Use the Field Extractor Tool
There are going to be cases where the data will be uploaded as is, so Splunk will need some help to change from a simple raw log line to a more structured log (or event, in this case) so that it's easier to create search queries.

Remember, all the files you need to upload are located in the Google Drive link I've shared with [you](https://drive.google.com/drive/folders/1YHRYjsqDl0PSqZTwRzIMnliRdpjvcqG_?usp=sharing)

## Extract New Fields
Let's provide a name SystemID to a first field in `userdataset.csv` using Regular Expressions, then search for all SystemID and State.

- Go to the "Search & Reporting" app
- Search for the data you've uploaded from the source `userdataset.csv`
- In the left menu, scroll down a little bit and click on the "+ Extract New Fields" link
- Select the Sample Events and click on Next
- Select Regular Expression and then click on Next
- Highlight one or more values in the sample event to create fields (it doesn't matter which fields or values you use)
- Validate your field extractions and remove values that are incorrectly highlighted in the Events tab
- Name the extraction and set permissions

## Search
- Search using the new fields, for example, `systemid`: `host=userdataset systemid=*`
- Look for the new fields you've extracted
