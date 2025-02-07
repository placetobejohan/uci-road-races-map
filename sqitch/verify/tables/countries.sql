-- Verify uci-road-races-map:tables/countries on pg

BEGIN;

-- There should be 100 countries
SELECT
    1 / (
        CASE
            WHEN (SELECT COUNT(*) FROM uci_road.countries) = 100
                THEN 1
            ELSE 0
        END
    );

ROLLBACK;
