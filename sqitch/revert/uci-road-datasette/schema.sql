-- Revert uci-road-races-map:uci-road-datasette/schema from pg
BEGIN;
DROP SCHEMA uci_road_datasette;
COMMIT;

