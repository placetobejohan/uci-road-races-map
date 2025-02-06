-- Deploy uci-road-races-map:races_raw to pg
-- requires: raw/schema
BEGIN;

CREATE TABLE uci_road_raw.races (
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

\copy uci_road_raw.races FROM '/home/johan-maes/source/uci-road-races-map/01-load-races-into-db/UCICompetitions_ROA_2025.csv' WITH (FORMAT csv, HEADER true);

COMMIT;
