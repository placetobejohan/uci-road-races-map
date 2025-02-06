-- Verify uci-road-races-map:tables/classes on pg

BEGIN;

-- There should be 19 classes
SELECT
    1 / (
        CASE
            WHEN (SELECT COUNT(*) FROM uci_road.classes) = 19
                THEN 1
            ELSE 0
        END
    );

ROLLBACK;
