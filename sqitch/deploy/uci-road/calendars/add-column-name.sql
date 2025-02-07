-- Deploy uci-road-races-map:uci-road/calendars/add-column-name to pg
-- requires: uci-road-raw/filters
-- requires: uci-road/calendars/create-table

BEGIN;

ALTER TABLE uci_road.calendars ADD COLUMN name text;

-- We have to do a manual update because the codes don't match (numbers vs letters)
UPDATE uci_road.calendars
SET name = v.name
FROM (
    VALUES
    ('AFR', 'Africa Tour'),
    ('AME', 'America Tour'),
    ('ASI', 'Asia Tour'),
    ('EUR', 'Europe Tour'),
    ('MON', 'UCI Women''s WorldTour'),
    ('OCE', 'Oceania Tour'),
    ('UWT', 'UCI WorldTour')
) AS v (code, name)
WHERE calendars.code = v.code;

ALTER TABLE uci_road.calendars ALTER COLUMN name SET NOT NULL;

COMMIT;
