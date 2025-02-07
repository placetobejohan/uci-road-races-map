-- Revert uci-road-races-map:raw/filters from pg

BEGIN;

DROP EXTENSION http;

DROP TABLE uci_road_raw.filters;

COMMIT;
