# Split Data into Multiple Columns

Split the data into multiple columns using eval and rex.

```splunk
| makeresults
| eval _raw="1. xyz 2. dsh bh 3. sdh dsd() 4. trrt"
| rex field=_raw "(?<a>\d+)\.\s(?<b>[^\d]*)(?:$|\s)" max_match=0
| eval c=mvzip(a,b)
| mvexpand c
| eval no=mvindex(split(c,","),0), name=mvindex(split(c,","),1)
| rex field=name mode=sed "s/\(\)//g"
| table no, name
```

## Remove Null Entries from Chart
Remove all the Null Entries from chart using eval and If command.

```splunk
| makeresults | eval host="host1",T1=null(),T2="1",T3="2" | append [| makeresults | eval host="host1",T1="2",T2="4",T3="5"]| append [| makeresults | eval host="host1",T1="2",T2=null(),T3="5"]| append [| makeresults | eval host="host1",T1=null(),T2=null(),T3="6"]| eval found_all=if(isnull(T1) OR isnull(T2) OR isnull(T3),"No","Yes")
```
