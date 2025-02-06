# 2. Extract raw data and normalize tables 

## Data types

Choose data types based on the data available.

## Data

Seems like there's a cutoff date of 19 Oct, with the Tour of Guangxi being the last race of the season. Let's just keep everything for now and see how it goes.

## Lookup tables

### categories

We could split his up further into gender and age groups but let's keep it simple for now.

### classes



### countries

### Fetch names

Fetch the names from the API: https://www.uci.org/api/calendar/cwc?discipline=ROA (filters field)
Put raw data in a separate schema.
It's tempting to use the https extension for simplicity, then extract the data with JSONTABLE.