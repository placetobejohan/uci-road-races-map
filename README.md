# UCI World Tour cycling map

The goal of this project is to create a map of the UCI World Tour cycling races.


## Display data

datasette setup

### Extract data from postgres to SQLite

```
python3 -m venv .venv
source .venv/bin/activate
pip install psycopg sqlite-utils
```

### Installation

```
pipx install datasette
```


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

## Next steps

- Write about it on dev.to
- Send to Postgres weekly
- Publish if anyone's interested
