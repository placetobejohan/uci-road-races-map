-- Verify uci-world-tour-map:tables/races_raw_column_url on pg

BEGIN;

select request_url
from uci_world_tour.races_raw
where false;

ROLLBACK;
