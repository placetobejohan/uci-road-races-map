BEGIN;

CREATE OR REPLACE FUNCTION sqitch.verify_pgtap(pgtap_result text, message text)
RETURNS void AS $$
BEGIN
    IF pgtap_result LIKE 'not ok%' THEN
        RAISE EXCEPTION 'pgTAP assertion failed: % - %', message, pgtap_result;
    END IF;
END;
$$ LANGUAGE plpgsql;

COMMIT;
