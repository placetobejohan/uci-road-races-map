-- Revert uci-world-tour-map:tables/races_raw_column_url from pg

BEGIN;

alter table uci_world_tour.races_raw
drop column request_url;

COMMIT;
