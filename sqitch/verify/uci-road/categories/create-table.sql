-- Verify uci-road-races-map:tables/categories on pg

BEGIN;

SELECT *
FROM uci_road.categories
WHERE false;

ROLLBACK;
