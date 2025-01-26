# UCI World Tour map

The goal of this project is to create a map of the UCI World Tour.

## Retrieve data

Source is the UCI website: https://www.uci.org/api/calendar/upcoming?discipline=ROA

The response contains a list of filters. To keep things simple we will only look at the UCI World Tour (seasonId = 989).

The raw data is stored in JSONB format together with a timestamp of the last update.

## Model data

### Start and end date

Postgres' `daterange` would've been the best option but it is not supported by datasette so we will use two columns.

## Display data

datasette setup

## Tech stack

### Python

For retrieving the data from UCI website and storing it in the database.

### Postgres

For storing the data.

### Datasette

https://github.com/simonw/datasette/

For displaying the data, including the map.

Plugins required: 

- datasette-database-url
- datasette-cluster-map

### Sqitch

https://sqitch.org/

For database migrations

