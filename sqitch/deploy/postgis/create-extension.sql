-- Deploy uci-road-races-map:postgis/create-extension to pg

BEGIN;

CREATE SCHEMA postgis;
CREATE EXTENSION postgis SCHEMA postgis;

-- add postgis to the search_path, needed for internal postgis functions
ALTER DATABASE pro_cycling SET search_path TO postgis, pgtap, public;

COMMIT;
