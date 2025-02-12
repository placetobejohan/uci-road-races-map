-- Revert uci-road-races-map:uci-road-raw/units from pg

BEGIN;

DROP TABLE uci_road_raw.sovereign_states;

COMMIT;
