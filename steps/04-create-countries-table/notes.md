[TOC]

# Get list of countries

get an external list of countries, perhaps with geographic coordinates

## Check which format is used in datasette

https://datasette.io/plugins/datasette-cluster-map

latitude, longitude

There are several options for displaying a map:

- one map with points only: https://datasette.io/plugins/datasette-cluster-map
- geojson but one map per row: https://datasette.io/plugins/datasette-leaflet-geojson
- one map with geojson: https://datasette.io/plugins/datasette-geojson-map

We'll probably go for the first option and use centroids for each country. However, we can download polygons to keep our options open. The polygons are then transformed to points with postgis' ST_Centroid function.

## Natural earth

https://www.naturalearthdata.com/downloads/110m-cultural-vectors/

shape file can be imported into postgis with shp2pgsql

```bash
(echo "BEGIN;\n"; shp2pgsql -s 4326 data/ne_110m_admin_0_countries/ne_110m_admin_0_countries.shp uci_road_raw.countries; echo "\nCOMMIT;") > sqitch/deploy/uci-road-raw/countries.sql
```

Fields to keep:

- id
- iso 3 code
- geom
- full name

## Problem

UCI data set doesn't use ISO country codes! They use IOC country codes.
Parse it from https://en.wikipedia.org/wiki/Comparison_of_alphabetic_country_codes

KISS: just edit this answer to an sql insert: https://stackoverflow.com/a/11215190/9266796

## Next problem

Countries like Hong Kong, Andorra, Monaco are missing from the Natural Earth data set.

Try map subunits

I mistakenly took small scale the first time, let's go for large scale now

https://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-0-details/

Conclusion: use adm0_a3 together with the mappings

We can save those in one countries table with

- id
- iso_code
- ioc_code (which is the same if it's not mapped)
- name_en (this is the full name)
- geometry

- [x] Check out the readme of subunits download

https://gis.stackexchange.com/a/490330/286714

> No indexes have been created yet. Don't forget to do so if some query is not running fast enough.

## subunits issue

Too many entries for single countries. Let's try the map units data set.

## Combination of sovereign states units

### Error: Key (iso_code)=(ATG) already exists

Duplicate entries in the data set units?

Not in sovereign states, the issue is that query won't stop joining if the first join works

### Error: Key (iso_code)=(CHN) already exists

duplicate entries in the data set units?

China is not in the sovereign states data set! And has a duplicate entry in the map units data set.

Let's try joining on gu_a3

### ERROR:  null value in column "name" of relation "countries" violates not-null constraint
DETAIL:  Failing row contains (32, FRA, FRA, null, null).

- FRA is not an entry in sovereign states.
- also not in units

use iso_a3 instead of gu_a3

### ERROR:  null value in column "name" of relation "countries" violates not-null constraint
DETAIL:  Failing row contains (33, GBR, GBR, null, null).

Perhaps we should use countries after all? Together with units

### ERROR:  duplicate key value violates unique constraint "countries_iso_code_key"
DETAIL:  Key (iso_code)=(ATG) already exists.

duplicate entries in the data set units?

perhaps combine all three: first check countries, then sovereign states, then units

HALLELUJAH!