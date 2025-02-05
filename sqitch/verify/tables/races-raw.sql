-- Verify uci-road-races-map:races_raw on pg
BEGIN;

SELECT *
FROM uci_road.races_raw
WHERE FALSE;

ROLLBACK;
