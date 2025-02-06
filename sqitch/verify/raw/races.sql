-- Verify uci-road-races-map:races on pg
BEGIN;

-- There should be 711 races
SELECT
    1 / (
        CASE
            WHEN (SELECT COUNT(*) FROM uci_road_raw.races) = 711
                THEN 1
            ELSE 0
        END
    );

ROLLBACK;
