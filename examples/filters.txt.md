The general form of a splunk query:
	data source | f1 | f2 | f3

examples of filters:
where
dedup
stats
....

we chan change the order of filters:

data source | f1 | f2 | f3
data source | f2 | f1 | f3
...

In we have N filters we can reorder the filters in N! ways.

The question is in what order do we want the filters?

Thw answer:
data source | strongest filter | second strongest filter | ...

Why?
TBD

It is obvous that the second of these is better
data source | filter only women | filter only certain cases of cancer
data source | filter only certain of cancer | filter women
