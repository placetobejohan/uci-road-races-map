-- Verify uci-world-tour-map:tables/races on pg

BEGIN;

-- XXX Add verifications here.
SELECT *
FROM uci_world_tour.races
WHERE FALSE;

ROLLBACK;
