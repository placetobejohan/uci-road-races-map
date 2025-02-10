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