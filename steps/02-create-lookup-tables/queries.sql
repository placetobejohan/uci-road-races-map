SELECT
    name,
    category,
    class,
    to_date(date_from, 'MM/DD/YYYY') AS converted_date
FROM uci_road.races_raw
ORDER BY converted_date;

SELECT *
FROM uci_road.categories;

SELECT left(code, 1)
FROM uci_road.categories;

SELECT *
FROM uci_road.classes;

SELECT *
FROM uci_road.countries;

SELECT *
FROM uci_road_raw.races
WHERE name ILIKE '%nations%';
