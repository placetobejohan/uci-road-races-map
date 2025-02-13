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

-- Find geometry subtype and srs
SELECT
    geometrytype(geom),
    st_srid(geom)
FROM uci_road_raw.countries LIMIT 1;

-- check units
SELECT *
FROM uci_road_raw.races
WHERE NOT EXISTS (
    SELECT 1
    FROM uci_road_raw.units
    LEFT JOIN uci_road_raw.country_mappings
        ON units.adm0_a3 = country_mappings.iso_code
    WHERE
        races.country = units.adm0_a3
        OR races.country = country_mappings.ioc_code
);
-- This is also fine

-- Any duplicates?
SELECT
    adm0_a3,
    count(*)
FROM uci_road_raw.units
GROUP BY adm0_a3
ORDER BY count(*) DESC;
-- Yes so we'll have to use the countries table first

-- which are missing? there's also a sovereign states list but it contains fewer entries 
SELECT DISTINCT country
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
-- 14 items

-- Let's check the sovereign states data set as well
SELECT DISTINCT country
FROM uci_road_raw.races
WHERE NOT EXISTS (
    SELECT 1
    FROM uci_road_raw.sovereign_states
    LEFT JOIN uci_road_raw.country_mappings
        ON sovereign_states.iso_a3_eh = country_mappings.iso_code
    WHERE
        races.country = sovereign_states.iso_a3_eh
        OR races.country = country_mappings.ioc_code
);
-- only 8 items
-- so let's try a combination of sovereign_states and units

SELECT *
FROM uci_road_raw.units
WHERE adm0_a3 = 'CHN';

SELECT
    adm0_a3,
    gu_a3,
    iso_a3
FROM uci_road_raw.units
ORDER BY adm0_a3;

SELECT *
FROM uci_road_raw.sovereign_states
WHERE adm0_a3 = 'CHN';

SELECT *
FROM uci_road_raw.races
WHERE country = 'ANT';

SELECT *
FROM uci_road_raw.sovereign_states
WHERE adm0_a3 IN ('CHN', 'FRA', 'GBR');

SELECT *
FROM uci_road_raw.units
WHERE adm0_a3 = 'ATG';

SELECT
    adm0_a3,
    gu_a3,
    iso_a3,
    iso_a3_eh
FROM uci_road_raw.units
WHERE
    adm0_a3 IN (
        'CHN',
        'FRA',
        'GBR'
    )
ORDER BY adm0_a3;

SELECT *
FROM uci_road.countries;
