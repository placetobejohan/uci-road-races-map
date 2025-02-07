-- Verify uci-road-races-map:appschema on pg

BEGIN;

SELECT sqitch.run_pgtap_tests(
    $$
    SELECT has_schema('uci_road_raw')
    $$
);

ROLLBACK;
