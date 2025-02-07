-- Verify uci-road-races-map:tables/categories on pg

BEGIN;

SELECT sqitch.assert(
    (SELECT count(*) FROM uci_road.categories) = 6,
    'There should be 6 categories'
);

ROLLBACK;
