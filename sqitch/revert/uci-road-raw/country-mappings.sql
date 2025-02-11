-- Revert uci-road-races-map:uci-road-raw/iso-ioc-mappings from pg

BEGIN;

DROP TABLE uci_road_raw.country_mappings;

COMMIT;
