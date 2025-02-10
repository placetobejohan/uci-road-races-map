-- Verify uci-road-races-map:postgis/create-extension on pg

BEGIN;

SELECT sqitch.run_pgtap_tests(
    $$
    SELECT pgtap.has_extension('postgis')
    $$
);

ROLLBACK;
