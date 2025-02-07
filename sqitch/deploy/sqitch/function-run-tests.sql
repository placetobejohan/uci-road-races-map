BEGIN;

CREATE OR REPLACE FUNCTION sqitch.run_pgtap_tests(sql_query text)
RETURNS void AS $$
BEGIN
    PERFORM pgtap.no_plan();
    EXECUTE sql_query;
    PERFORM pgtap.finish(true);
END;
$$ LANGUAGE plpgsql;

COMMIT;
