-- Verify uci-road-races-map:tables/categories on pg

BEGIN;

-- There should be 6 categories
SELECT
    1 / (
        CASE
            WHEN (SELECT COUNT(*) FROM uci_road.categories) = 6
                THEN 1
            ELSE 0
        END
    );

ROLLBACK;
