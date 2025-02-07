-- Verify uci-road-races-map:schema on pg

BEGIN;

SELECT * FROM no_plan();
SELECT sqitch.verify_pgtap(
    has_schema('uci_road'),
    'Schema should exist'
);

ROLLBACK;
