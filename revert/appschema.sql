-- Revert uci-world-tour-map:appschema from pg

BEGIN;

drop schema uci_world_tour;

COMMIT;
