# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `examples/streaming_vs_non_streaming.txt.md:9` - says "Splunk does have to finish cmd1 in order to start working on cmd2", which is the opposite of the point being taught (streaming commands pipeline line by line; line 13 contrasts this with `sort`). Change to "does not have to".
- `exercises/advanced/10_lookup_tables/solution.md:6` - both solution queries (also line 12) look up `product_name_to_price_new.csv`, but the file shipped with the exercise is `exercises/advanced/10_lookup_tables/product_name_to_price.csv`. Use the shipped name.
- `exercises/advanced/01_moving_filters_around/exercise.md:3` - tells students to import "the `access_combined.log` file which is in this folder", but the folder only has exercise.md/solution.md; the file is `data/access_combined.log`. Fix the path (the later exercises that reuse it inherit the same pointer).
- `exercises/basic/04-Searching-in-Splunk.md:94` - `top action by referer_domain` misspells the field extracted on line 75 as `referrer_domain`, so the query returns nothing. Fix the spelling.
- `exercises/basic/04-Searching-in-Splunk.md:66` - the task (line 61) asks to rename `lat`/`lon` to `latitude`/`longitude`, but the query does `rename latitude as lat longitude as lon`, the reverse. Also the section heading and step 1 (lines 52, 55) talk about Hawaii while every query filters `place=*California`. Make text and queries agree.
- `examples/mvcount.txt.md:3` - a public repo carrying a third party's personal email address (`doronveltzer@...`) in an example that otherwise has no explanation. Replace with placeholder addresses (example.com) and add the mvcount query it is meant to illustrate.

## Low

- `exercises/advanced/02_table_visualization/solution.md:6` - "with 'table' command:" is followed by nothing; complete the solution or drop the bullet.
- `exercises/advanced/09_eval/solution.md:6` - `stats count(...) as success | table _time, success`: after `stats` there is no `_time` field, so that column is always empty. Drop `_time` from the table.
- `examples/top.txt.md:7-9` - `top 2 status` returns the two most common distinct values, but the expected output lists `200` twice. Show two different status codes.
- `exercises/basic/00-Install-Splunk.md:8` - installs Splunk 8.1.0 (and links 8.1.2 for macOS/Windows on lines 32/38, a different version), both long out of support; `exercises/basic/08-Reports.md:28` links the 7.2.3 docs. Update to a supported release and the version-less docs URL.
- `exercises/basic/01-Upload-Data-Manually.md:11` - sends students to Google Drive for `cbg_patterns.csv`, the AirBnB and the Titanic data (lines 23, 26) although all three are committed under `data/`. Point at the repo copies so the exercises do not depend on external share links.
- `rsconstruct.toml:13-14` - zspell spellchecks only `exercises/`, not `examples/` (which has misspellings such as "obvous", "Thw", "chan" in `examples/filters.txt.md:12,24,30`). Add `examples` to `src_dirs` and fix the words.
- `doc/TODO.txt:2` - "add shellcheck checking of all bash scripts" is done (`rsconstruct.toml:16-17`); remove the stale item.
