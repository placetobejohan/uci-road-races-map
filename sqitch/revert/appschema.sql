-- Revert uci-road-races-map:appschema from pg

BEGIN;

DROP SCHEMA uci_road;

COMMIT;
