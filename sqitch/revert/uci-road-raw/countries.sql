-- Revert uci-road-races-map:uci-road-raw/countries from pg

BEGIN;

DROP TABLE uci_road_raw.countries;

COMMIT;
