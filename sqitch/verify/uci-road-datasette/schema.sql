-- Verify uci-road-races-map:uci-road-datasette/schema on pg
BEGIN;
SELECT
    sqitch.run_pgtap_tests($$
        SELECT
            has_schema('uci_road_datasette') $$);
ROLLBACK;

