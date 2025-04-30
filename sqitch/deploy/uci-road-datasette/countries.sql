-- Deploy uci-road-races-map:uci-road-datasette/countries to pg
BEGIN;
-- Extract the largest polygon from each country to get long and lat
CREATE TABLE uci_road_datasette.countries AS
SELECT
    id,
    iso_code,
    ioc_code,
    name,
    population,
    postgis.st_X(postgis.st_Centroid(part)) AS longitude,
    postgis.st_Y(postgis.st_Centroid(part)) AS latitude
FROM
    uci_road.countries,
    LATERAL (
        SELECT
            (postgis.st_Dump(geom)).geom AS part
        ORDER BY
            postgis.st_Area((postgis.st_Dump(geom)).geom) DESC
        LIMIT 1) AS main_part;
COMMIT;

