-- Deploy uci-road-races-map:tables/calendars to pg
-- requires: schema
-- requires: raw/races

BEGIN;

-- XXX Add DDLs here.
CREATE TABLE uci_road.calendars (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code varchar(3) NOT NULL
);

INSERT INTO uci_road.calendars (code)
SELECT DISTINCT calendar AS code
FROM uci_road_raw.races
WHERE calendar IS NOT null
ORDER BY code;

COMMIT;
