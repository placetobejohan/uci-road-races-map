-- Verify uci-road-races-map:races on pg
BEGIN;

SELECT * FROM no_plan();
SELECT sqitch.assert_pgtap(
    pgtap.isnt_empty('SELECT 1 FROM uci_road_raw.races'),
    'The table should be populated'
);

ROLLBACK;
