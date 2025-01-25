-- Revert uci-world-tour-map:races_raw from pg
BEGIN;

DROP TABLE uci_world_tour.races_raw;

COMMIT;

