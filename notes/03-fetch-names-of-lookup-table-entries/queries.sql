SELECT content::jsonb -> 'filters' AS filters
FROM http_get('https://www.uci.org/api/calendar/cwc?discipline=ROA');

SELECT *
FROM uci_road_raw.filters;

-- unpack filters
SELECT
    json_data,
    label,
    code,
    name
FROM uci_road_raw.filters,
    json_table(json_data, '$[*]' columns(
        label text path '$.label',
        nested path '$.items[*]' columns(
            code text path '$.code',
            name text path '$.text'
        )
    ))
WHERE label = 'UCI Series';

SELECT *
FROM uci_road.calendars;

SELECT *
FROM uci_road_raw.races
WHERE calendar IN ('MON', 'UWT');

CREATE EXTENSION pgtap;
DROP EXTENSION pgtap;
DROP SCHEMA pgtap;
SHOW search_path;

SELECT * FROM no_plan();
SELECT has_function('sqitch', 'assert_pgtap', ARRAY['text', 'text']);
SELECT has_function('assert_pgtap');
