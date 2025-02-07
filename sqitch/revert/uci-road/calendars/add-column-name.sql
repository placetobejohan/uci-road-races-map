-- Revert uci-road-races-map:uci-road/calendars/add-column-name from pg

BEGIN;

ALTER TABLE uci_road.calendars DROP COLUMN name;

COMMIT;
