-- Verify uci-road-races-map:appschema on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege('uci_road_raw', 'usage');

ROLLBACK;
