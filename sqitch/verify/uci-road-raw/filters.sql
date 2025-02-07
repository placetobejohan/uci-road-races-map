-- Verify uci-road-races-map:raw/filters on pg

BEGIN;

SELECT sqitch.run_pgtap_tests(
    $$
    SELECT pgtap.isnt_empty('SELECT 1 FROM uci_road_raw.filters')
    $$
);

ROLLBACK;
