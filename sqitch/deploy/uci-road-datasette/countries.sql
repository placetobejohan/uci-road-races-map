-- Deploy uci-road-races-map:uci-road-datasette/countries to pg
BEGIN;
-- Extract coordinates for each country with fallback options:
-- 1. Try centroid of entire geometry (all polygons)
-- 2. If not within any polygon, use centroid of largest polygon
-- 3. If still not within, use pointonsurface of largest polygon
CREATE TABLE uci_road_datasette.countries AS
SELECT
    id,
    iso_code,
    ioc_code,
    name,
    population,
    postgis.st_X(point) AS longitude,
    postgis.st_Y(point) AS latitude
FROM
    uci_road.countries,
    LATERAL (
        SELECT
            (postgis.st_Dump(geom)).geom AS part
        ORDER BY
            postgis.st_Area((postgis.st_Dump(geom)).geom) DESC
        LIMIT 1) AS main_part,
    LATERAL (
        SELECT
            CASE WHEN postgis.st_contains(geom, postgis.st_centroid(geom)) THEN
                postgis.st_centroid(geom)
            WHEN postgis.st_contains(part, postgis.st_centroid(part)) THEN
                postgis.st_centroid(part)
            ELSE
                postgis.st_pointonsurface(part)
            END AS point) AS point_calc;
COMMIT;

