-- Verify uci-road-races-map:schema on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege('uci_road', 'usage');

ROLLBACK;
