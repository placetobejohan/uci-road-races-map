# Fetch races

Source is the UCI website: https://www.uci.org/api/calendar/upcoming?discipline=ROA

The response contains a list of filters. To keep things simple we will only look at the UCI World Tour (seasonId = 989).

The raw data is stored in JSONB format together with a timestamp of the last update.

