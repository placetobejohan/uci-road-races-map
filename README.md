# UCI World Tour map

The goal of this project is to create a map of the UCI World Tour.

## Retrieve data

- [ ] Get road races from UCI website: https://www.uci.org/api/calendar/upcoming?discipline=ROA

The raw data is stored in a JSON format together with the date of the last update.

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

