-- Deploy uci-road-races-map:copy-races-from-csv to pg

BEGIN;

-- XXX Add DDLs here.
\copy uci_road.races_raw FROM '/home/johan-maes/data/UCICompetitions_ROA_2025.csv' WITH (FORMAT csv, HEADER true);


COMMIT;
