-- Verify uci-road-races-map:uci-road/calendars/add-column-name on pg

BEGIN;

SELECT sqitch.assert(
    NOT EXISTS (
        SELECT 1
        FROM uci_road.calendars
        WHERE name IS null
    ),
    'All rows should have a name'
);

ROLLBACK;
