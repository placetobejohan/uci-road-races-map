-- Revert uci-road-races-map:races_raw from pg
BEGIN;

-- XXX Add DDLs here.
DROP TABLE uci_road_raw.races;

COMMIT;
