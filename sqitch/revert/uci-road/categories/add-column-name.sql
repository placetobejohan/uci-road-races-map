-- Revert uci-road-races-map:uci-road/categories/add-column-name from pg

BEGIN;

ALTER TABLE uci_road.categories DROP COLUMN name;

COMMIT;
