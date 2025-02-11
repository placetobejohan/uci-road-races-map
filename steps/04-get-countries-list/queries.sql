-- Active: 1714505613653@@localhost@5432@pro_cycling
SELECT
    country,
    name,
    website
FROM uci_road_raw.races
ORDER BY country, name;

SELECT * FROM uci_road_raw.countries;

SELECT
    iso_a3,
    iso_a3_eh,
    iso_n3,
    name
FROM uci_road_raw.countries
WHERE iso_a3 != iso_a3_eh;

SELECT
    gid,
    iso_a3,
    iso_a3_eh,
    iso_n3,
    iso_n3_eh,
    name,
    name_en,
    adm0_iso,
    geom
FROM uci_road_raw.countries
ORDER BY iso_a3, iso_a3_eh;

SELECT *
FROM uci_road_raw.countries
WHERE name = 'Guadeloupe';

SELECT *
FROM uci_road_raw.countries
ORDER BY adm0_iso;

-- Does every race country have an entry?
SELECT *
FROM uci_road_raw.races
WHERE NOT EXISTS (
    SELECT 1
    FROM uci_road_raw.countries
    WHERE races.country = countries.adm0_iso
);

SELECT *
FROM uci_road_raw.country_mappings;

SELECT *
FROM sqitch.changes;
