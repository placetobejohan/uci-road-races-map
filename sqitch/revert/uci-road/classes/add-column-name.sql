-- Revert uci-road-races-map:uci-road/classes/add-column-name from pg

BEGIN;

ALTER TABLE uci_road.classes DROP COLUMN name;

COMMIT;
