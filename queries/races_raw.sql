SELECT
    *
FROM
    races_raw;

SELECT
    json_data -> 'filters' as filters,
    json_data -> 'items' -> 0 as races
FROM
    races_raw;

