-- Verify uci-road-races-map:raw/filters on pg

BEGIN;

SELECT *
FROM uci_road_raw.filters
WHERE false;

ROLLBACK;
