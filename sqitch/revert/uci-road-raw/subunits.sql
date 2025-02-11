-- Revert uci-road-races-map:uci-road-raw/subunits from pg

BEGIN;

DROP TABLE uci_road_raw.subunits;

COMMIT;
