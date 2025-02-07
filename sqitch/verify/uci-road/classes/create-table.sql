-- Verify uci-road-races-map:tables/classes on pg

BEGIN;

SELECT sqitch.run_pgtap_tests(
    $$
    SELECT pgtap.isnt_empty('SELECT 1 FROM uci_road.classes')
    $$
);

ROLLBACK;
