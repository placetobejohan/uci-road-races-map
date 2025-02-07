-- Verify uci-road-races-map:tables/classes on pg

BEGIN;

SELECT * FROM no_plan();
SELECT sqitch.assert_pgtap(
    pgtap.isnt_empty('SELECT 1 FROM uci_road.classes'),
    'The table should be populated'
);

ROLLBACK;
