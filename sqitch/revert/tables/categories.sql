-- Revert uci-road-races-map:tables/categories from pg

BEGIN;

DROP TABLE uci_road.categories;

COMMIT;
