CREATE OR REPLACE FUNCTION assert(condition boolean, message text)
RETURNS void AS $$
BEGIN
    IF NOT condition THEN
        RAISE EXCEPTION '%', message;
    END IF;
END;
$$ LANGUAGE plpgsql;
