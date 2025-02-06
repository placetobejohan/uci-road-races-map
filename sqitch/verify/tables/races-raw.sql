-- Verify uci-road-races-map:races_raw on pg
BEGIN;

-- There should be 711 races
SELECT
    1 / (
        CASE
            WHEN (SELECT COUNT(*) FROM uci_road.races_raw) = 711
                THEN 1
            ELSE 0
        END
    );

ROLLBACK;
