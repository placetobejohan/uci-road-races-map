SELECT content::jsonb -> 'filters' AS filters
FROM http_get('https://www.uci.org/api/calendar/cwc?discipline=ROA');

SELECT *
FROM uci_road_raw.filters;
