-- Verify uci-road-races-map:tables/classes on pg

BEGIN;

SELECT assert(
    (SELECT count(*) FROM uci_road.classes) = 19,
    'There should be 19 classes'
);

ROLLBACK;
