-- Verify uci-road-races-map:appschema on pg

BEGIN;

SELECT * FROM no_plan();
SELECT sqitch.verify_pgtap(
    has_schema('uci_road_raw'),
    'Schema should exist'
);

ROLLBACK;
