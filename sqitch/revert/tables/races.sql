-- Revert uci-world-tour-map:tables/races from pg

BEGIN;

-- XXX Add DDLs here.
DROP TABLE uci_world_tour.races;

COMMIT;
