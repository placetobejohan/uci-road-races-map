-- Revert uci-road-races-map:tables/calendars from pg

BEGIN;

DROP TABLE uci_road.calendars;

COMMIT;
