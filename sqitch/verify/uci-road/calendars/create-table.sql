-- Verify uci-road-races-map:tables/calendars on pg

BEGIN;

SELECT assert(
    (SELECT count(*) FROM uci_road.calendars) = 7,
    'There should be 7 calendars'
);

ROLLBACK;
