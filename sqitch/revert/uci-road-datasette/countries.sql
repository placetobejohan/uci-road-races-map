-- Revert uci-road-races-map:uci-road-datasette/countries from pg
BEGIN;
DROP TABLE uci_road_datasette.countries;
COMMIT;

