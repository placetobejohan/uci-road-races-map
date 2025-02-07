# Fetch names of categories, classes, calendars

Fetch the names from the API: https://www.uci.org/api/calendar/cwc?discipline=ROA (filters field)
Put raw data in a separate schema.
It's tempting to use the http extension for simplicity, then extract the data with JSONTABLE.

## fetch data with http extension

save json in table filters

## extract data with JSONTABLE

### Calendars

Codes are not the same so we'll have to insert manually.

Why MON? Possibly Mondial, first chatgpt invented something else: https://chatgpt.com/share/67a61ab6-180c-8004-8dc9-82ea957cd877

> It's one of those quirks of cycling terminology (by developers)

### pgtap

Perhaps 1099 is going a little bit overboard but I want to try it out.

Nevermind, I need to have a test plan according to pgtap.

Workaround: `SELECT * FROM no_plan();` at the top of the verify script. I guess I could live with that for now.