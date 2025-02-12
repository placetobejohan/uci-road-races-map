-- Verify uci-road-races-map:uci-road/countries/create-table on pg

BEGIN;

SELECT sqitch.run_pgtap_tests(
    $$
    SELECT pgtap.isnt_empty('SELECT 1 FROM uci_road.countries')
    $$
);

ROLLBACK;
