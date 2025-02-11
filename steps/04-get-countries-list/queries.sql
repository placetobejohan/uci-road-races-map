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

SELECT
    adm0_iso,
    iso_a3_eh,
    name
FROM uci_road_raw.countries
WHERE name ILIKE '%singapore%';

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

-- Use country if there's no mapping
SELECT *
FROM uci_road_raw.races
WHERE NOT EXISTS (
    SELECT 1
    FROM uci_road_raw.countries
    LEFT JOIN uci_road_raw.country_mappings
        ON countries.iso_a3_eh = country_mappings.iso_code
    WHERE
        races.country = countries.iso_a3_eh
        OR races.country = country_mappings.ioc_code
);

SELECT *
FROM uci_road_raw.subunits
WHERE name = 'Singapore';

-- Use subunit if there's no mapping
SELECT *
FROM uci_road_raw.races
WHERE NOT EXISTS (
    SELECT 1
    FROM uci_road_raw.subunits
    LEFT JOIN uci_road_raw.country_mappings
        ON subunits.iso_a3_eh = country_mappings.iso_code
    WHERE
        races.country = subunits.iso_a3_eh
        OR races.country = country_mappings.ioc_code
);

-- only KOS left, we're almost there
-- is it found anywhere in subunits?
SELECT *
FROM uci_road_raw.subunits
WHERE name ILIKE '%kosovo%';

-- doesn't have iso_a3_eh
-- try sov_a3, adm0_a3, gu_a3, su_a3, brk_a3
SELECT *
FROM uci_road_raw.races
WHERE NOT EXISTS (
    SELECT 1
    FROM uci_road_raw.subunits
    LEFT JOIN uci_road_raw.country_mappings
        ON subunits.adm0_a3 = country_mappings.iso_code
    WHERE
        races.country = subunits.adm0_a3
        OR races.country = country_mappings.ioc_code
);

-- YES!
