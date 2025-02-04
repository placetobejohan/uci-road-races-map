-- Verify uci-world-tour-map:appschema on pg

BEGIN;

select pg_catalog.has_schema_privilege('uci_world_tour', 'usage');

ROLLBACK;
