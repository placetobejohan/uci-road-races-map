-- Revert uci-road-races-map:tables/classes from pg

BEGIN;

DROP TABLE uci_road.classes;

COMMIT;
