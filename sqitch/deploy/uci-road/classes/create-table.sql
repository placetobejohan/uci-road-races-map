-- Deploy uci-road-races-map:tables/classes to pg
-- requires: appschema
-- requires: tables/races-raw

BEGIN;

CREATE TABLE uci_road.classes (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code varchar(6) NOT NULL UNIQUE
);

INSERT INTO uci_road.classes (code)
SELECT DISTINCT class AS code
FROM uci_road_raw.races
WHERE class IS NOT null
ORDER BY code;

COMMIT;
