BEGIN;

DROP EXTENSION pgtap;
DROP SCHEMA pgtap;

-- reset the search_path
ALTER DATABASE pro_cycling SET search_path TO public;

COMMIT;
