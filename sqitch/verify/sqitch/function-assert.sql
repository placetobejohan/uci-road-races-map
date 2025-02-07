BEGIN;

SELECT has_function_privilege('assert(boolean, text)', 'execute');

ROLLBACK;
