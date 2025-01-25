-- Deploy uci-world-tour-map:tables/races_raw_column_url to pg

BEGIN;

alter table uci_world_tour.races_raw
add column request_url text not null default 'https://www.uci.org/api/calendar/upcoming?discipline=ROA';

COMMIT;
