BEGIN;

CREATE SCHEMA pgtap;
CREATE EXTENSION pgtap SCHEMA pgtap;

-- add pgtap to the search_path, needed for internal pgtap functions
ALTER DATABASE pro_cycling SET search_path TO pgtap, public;

COMMIT;
