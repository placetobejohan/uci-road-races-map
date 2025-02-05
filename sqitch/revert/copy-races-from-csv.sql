-- Revert uci-road-races-map:copy-races-from-csv from pg

BEGIN;

-- XXX Add DDLs here.
TRUNCATE uci_road.races_raw;

COMMIT;
