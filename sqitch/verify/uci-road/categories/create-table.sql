-- Verify uci-road-races-map:tables/categories on pg

BEGIN;

SELECT * FROM no_plan();
SELECT sqitch.assert_pgtap(
    pgtap.isnt_empty('SELECT 1 FROM uci_road.categories'),
    'The table should be populated'
);

ROLLBACK;
