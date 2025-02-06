-- Deploy uci-road-races-map:races_raw to pg
-- requires: appschema
BEGIN;

CREATE TABLE uci_road.races_raw (
    date_from text,
    date_to text,
    name text,
    venue text,
    country text,
    category text,
    calendar text,
    class text,
    email text,
    website text
);

COMMIT;
