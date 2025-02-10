-- Deploy uci-road-races-map:tables/categories to pg
-- requires: raw/schema
-- requires: raw/races

BEGIN;

CREATE TABLE uci_road.categories (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code varchar(2) NOT NULL UNIQUE
);

INSERT INTO uci_road.categories (code)
SELECT DISTINCT category AS code
FROM uci_road_raw.races
WHERE category IS NOT NULL
ORDER BY code;

COMMIT;
