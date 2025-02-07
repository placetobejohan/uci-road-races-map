-- Deploy uci-road-races-map:tables/countries to pg
-- requires: schema
-- requires: raw/races

BEGIN;

CREATE TABLE uci_road.countries (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code varchar(3) NOT NULL
);

INSERT INTO uci_road.countries (code)
SELECT DISTINCT country AS code
FROM uci_road_raw.races
WHERE country IS NOT null
ORDER BY code;

COMMIT;
