-- Deploy uci-road-races-map:uci-road/races/create-table to pg
-- requires: uci-road/calendars/create-table
-- requires: uci-road/categories/create-table
-- requires: uci-road/countries/create-table
-- requires: uci-road-raw/races

BEGIN;

CREATE TABLE uci_road.races (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name text NOT NULL,
    date_from date NOT NULL,
    date_to date NOT NULL,
    venue text NULL,
    email text NOT NULL,
    website text NULL,
    country_id integer NOT NULL REFERENCES uci_road.countries (id),
    category_id integer NULL REFERENCES uci_road.categories (id),
    calendar_id integer NOT NULL REFERENCES uci_road.calendars (id),
    class_id integer NOT NULL REFERENCES uci_road.classes (id)
);

INSERT INTO uci_road.races (name, date_from, date_to, venue, email, website, country_id, category_id, calendar_id, class_id)
SELECT
    races.name,
    to_date(races.date_from, 'MM/DD/YYYY') AS date_from,
    to_date(races.date_to, 'MM/DD/YYYY') AS date_to,
    races.venue,
    races.email,
    races.website,
    countries.id AS country_id,
    categories.id AS category_id,
    calendars.id AS calendar_id,
    classes.id AS class_id
FROM uci_road_raw.races
INNER JOIN uci_road.countries
    ON races.country = countries.ioc_code
LEFT JOIN uci_road.categories
    ON races.category = categories.code
INNER JOIN uci_road.calendars
    ON races.calendar = calendars.code
INNER JOIN uci_road.classes
    ON races.class = classes.code;

COMMIT;
