-- Revert uci-world-tour-map:races_raw from pg
BEGIN;

-- XXX Add DDLs here.
DROP TABLE uci_world_tour.races_raw;

COMMIT;