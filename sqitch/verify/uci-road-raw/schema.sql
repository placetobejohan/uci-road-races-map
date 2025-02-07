-- Verify uci-road-races-map:appschema on pg

BEGIN;

SELECT * FROM no_plan();
SELECT sqitch.assert_pgtap(
    has_schema('uci_road_raw'),
    'Schema should exist'
);

ROLLBACK;
