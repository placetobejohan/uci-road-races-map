-- Verify uci-road-races-map:copy-races-from-csv on pg

BEGIN;

SELECT
    1 / (
        CASE
            WHEN (SELECT COUNT(*) FROM uci_road.races_raw) = 711
                THEN 1
            ELSE 0
        END
    );

ROLLBACK;
