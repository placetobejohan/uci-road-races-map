BEGIN;

SELECT * FROM no_plan();

SELECT sqitch.verify_pgtap(
    pgtap.has_function('sqitch', 'verify_pgtap', ARRAY['text', 'text']),
    'Function sqitch.verify_pgtap() should exist'
);

ROLLBACK;
