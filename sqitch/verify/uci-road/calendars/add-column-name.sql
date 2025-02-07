-- Verify uci-road-races-map:uci-road/calendars/add-column-name on pg

BEGIN;

SELECT * FROM no_plan();
SELECT sqitch.assert_pgtap(
    pgtap.is_empty('SELECT 1 FROM uci_road.calendars WHERE name IS null'),
    'All rows should have a name'
);

ROLLBACK;
