-- Revert uci-world-tour-map:appschema from pg

BEGIN;

DROP SCHEMA uci_world_tour;

COMMIT;
