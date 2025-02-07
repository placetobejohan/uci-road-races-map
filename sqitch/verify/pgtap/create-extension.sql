BEGIN;

SELECT * FROM no_plan();
SELECT pgtap.has_extension('pgtap');

ROLLBACK;
