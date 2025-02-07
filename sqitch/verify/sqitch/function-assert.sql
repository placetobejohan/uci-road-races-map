BEGIN;

SELECT * FROM no_plan();

SELECT sqitch.assert_pgtap(
    has_function('sqitch', 'assert_pgtap', ARRAY['text', 'text']),
    'Function sqitch.assert_pgtap() should exist'
);

ROLLBACK;
