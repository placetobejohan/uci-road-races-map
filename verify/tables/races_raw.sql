-- Verify uci-world-tour-map:races_raw on pg
BEGIN;

SELECT
    *
FROM
    uci_world_tour.races_raw
WHERE
    FALSE;

ROLLBACK;

