-- Verify uci-road-races-map:schema on pg

BEGIN;

SELECT sqitch.run_pgtap_tests(
    $$
    SELECT has_schema('uci_road')
    $$
);

ROLLBACK;
