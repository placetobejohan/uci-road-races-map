-- Verify uci-road-races-map:tables/calendars on pg

BEGIN;

-- There should be 7 calendars
SELECT
    1 / (
        CASE
            WHEN (SELECT COUNT(*) FROM uci_road.calendars) = 7
                THEN 1
            ELSE 0
        END
    );

ROLLBACK;
