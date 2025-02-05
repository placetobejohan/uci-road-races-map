# Fetch races

Source is the UCI website: https://www.uci.org/api/calendar/upcoming?discipline=ROA

The response contains a list of filters. To keep things simple we will only look at the Men Elite, (raceCategory = ME), UCI World Tour (seasonId = 989) and UCI events (seasonId = 988).

The raw data is stored in JSONB format together with a timestamp of the last update.

## Update

I found a link to download an XLS file: https://www.uci.org/calendar/road/2ruOnavHX0dMGTCRozdYAU?discipline=ROA#

That means we can load the data from the XLS file into the database with a COPY query. No need for the JSONB then.