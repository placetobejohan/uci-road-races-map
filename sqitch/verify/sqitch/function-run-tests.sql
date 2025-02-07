BEGIN;

SELECT sqitch.run_pgtap_tests(
    $$
    SELECT pgtap.has_function('sqitch', 'run_pgtap_tests', ARRAY['text'])
    $$
);

ROLLBACK;
