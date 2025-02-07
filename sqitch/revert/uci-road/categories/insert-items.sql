-- Revert uci-road-races-map:tables/categories from pg

BEGIN;

TRUNCATE uci_road.categories;

COMMIT;
