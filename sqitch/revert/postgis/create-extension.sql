-- Revert uci-road-races-map:postgis/create-extension from pg

BEGIN;

DROP EXTENSION postgis;
DROP SCHEMA postgis;

-- reset the search_path
ALTER DATABASE pro_cycling SET search_path TO pgtap, public;

COMMIT;
