-- Verify uci-road-races-map:tables/calendars on pg

BEGIN;

SELECT * FROM no_plan();
SELECT sqitch.verify_pgtap(
    pgtap.isnt_empty('SELECT 1 FROM uci_road.calendars'),
    'The table should be populated'
);

ROLLBACK;
