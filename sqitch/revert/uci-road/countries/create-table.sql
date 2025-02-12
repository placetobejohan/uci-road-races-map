-- Revert uci-road-races-map:uci-road/countries/create-table from pg

BEGIN;

DROP TABLE uci_road.countries;

COMMIT;
