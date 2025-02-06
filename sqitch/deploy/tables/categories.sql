-- Deploy uci-road-races-map:tables/categories to pg
-- requires: appschema
-- requires: tables/races-raw

BEGIN;

CREATE TABLE uci_road.categories (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code varchar(2) NOT NULL
);

INSERT INTO uci_road.categories (code)
SELECT DISTINCT category AS code
FROM uci_road.races_raw
WHERE category IS NOT NULL
ORDER BY code;

ALTER TABLE uci_road.categories ADD COLUMN name text;

UPDATE uci_road.categories
SET
    name
    = (CASE left(code, 1)
        WHEN 'M' THEN 'Men '
        WHEN 'W' THEN 'Women '
    END)
    || CASE right(code, 1)
        WHEN 'E' THEN 'Elite'
        WHEN 'J' THEN 'Junior'
        WHEN 'U' THEN 'Under 23'
    END;

ALTER TABLE uci_road.categories ALTER COLUMN name SET NOT NULL;

COMMIT;
