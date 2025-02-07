-- Deploy uci-road-races-map:raw/filters to pg
-- requires: raw/schema

BEGIN;

CREATE EXTENSION http;

CREATE TABLE uci_road_raw.filters AS
SELECT content::jsonb -> 'filters' AS json_data
FROM http_get('https://www.uci.org/api/calendar/cwc?discipline=ROA');

COMMIT;
