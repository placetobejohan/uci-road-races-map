-- Verify uci-road-races-map:races on pg
BEGIN;

SELECT assert(
    (SELECT count(*) FROM uci_road_raw.races) = 711,
    'There should be 711 races'
);

ROLLBACK;
