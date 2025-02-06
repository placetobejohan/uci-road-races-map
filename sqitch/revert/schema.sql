-- Revert uci-road-races-map:schema from pg

BEGIN;

DROP SCHEMA uci_road;

COMMIT;
