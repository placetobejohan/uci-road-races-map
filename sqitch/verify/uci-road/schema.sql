-- Verify uci-road-races-map:schema on pg

BEGIN;

SELECT * FROM no_plan();
SELECT sqitch.assert_pgtap(
    has_schema('uci_road'),
    'Schema should exist'
);

ROLLBACK;
