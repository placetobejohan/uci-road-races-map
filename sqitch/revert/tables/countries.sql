-- Revert uci-road-races-map:tables/countries from pg

BEGIN;

DROP TABLE uci_road.countries;

COMMIT;
