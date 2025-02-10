-- Verify uci-road-races-map:uci-road/classes/add-column-name on pg

BEGIN;

SELECT sqitch.run_pgtap_tests(
    $$
    SELECT pgtap.is_empty('SELECT 1 FROM uci_road.classes WHERE name IS null')
    $$
);

ROLLBACK;
