SELECT *
FROM uci_road.races;

SELECT *
FROM uci_road.races
INNER JOIN uci_road.countries
    ON races.country_id = countries.id
WHERE countries.iso_code = 'BEL';

-- Which country has the most races?
SELECT
    countries.name,
    COUNT(races.id) AS races_count
FROM uci_road.races
INNER JOIN uci_road.countries
    ON races.country_id = countries.id
GROUP BY countries.name
ORDER BY races_count DESC;
-- France! Once again we are trumped by the French.

-- Bonus: Which country has the most races per capita?
-- We'll have to add the population to the countries table.
SELECT
    name_en,
    pop_est,
    pop_year,
    TO_CHAR(pop_est / 1000000, 'FM999999990.99') AS pop_millions
FROM uci_road_raw.units
WHERE pop_year != 2019
ORDER BY pop_est DESC;

SELECT *
FROM uci_road.countries;

-- Which country has the most races per capita?
SELECT
    countries.name,
    COUNT(races.id) AS races_count,
    ROUND(1000000 * COUNT(races)::numeric / countries.population, 2) AS races_per_million
FROM uci_road.races
INNER JOIN uci_road.countries
    ON races.country_id = countries.id
GROUP BY countries.name, countries.population
ORDER BY races_count DESC, races_per_million DESC;

-- Eat that, France, fat-bottomed girls are coming to town!
