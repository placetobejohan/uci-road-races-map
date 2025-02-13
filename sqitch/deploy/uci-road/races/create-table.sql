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

COMMIT;
