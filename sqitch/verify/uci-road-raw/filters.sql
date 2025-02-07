-- Verify uci-road-races-map:raw/filters on pg

BEGIN;

SELECT * FROM no_plan();
SELECT sqitch.verify_pgtap(
    pgtap.isnt_empty('SELECT 1 FROM uci_road_raw.filters'),
    'The table should be populated'
);

ROLLBACK;
