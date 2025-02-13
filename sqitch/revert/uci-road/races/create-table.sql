-- Revert uci-road-races-map:uci-road/races/create-table from pg

BEGIN;

DROP TABLE uci_road.races;

COMMIT;
