-- Deploy uci-road-races-map:uci-road/countries/create-table to pg
-- requires: uci-road/schema

BEGIN;

CREATE TABLE uci_road.countries (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    iso_code varchar(3) NOT NULL UNIQUE,
    ioc_code varchar(3) NOT NULL UNIQUE,
    name text NOT NULL,
    geom GEOMETRY (MULTIPOLYGON, 4326) NOT NULL
);

-- start from the races table to see which countries we need
WITH race_countries AS (
    SELECT DISTINCT
        country AS ioc_code,
        -- if there's no mapping ISO and IOC code are the same
        COALESCE(country_mappings.iso_code, races.country) AS iso_code
    FROM uci_road_raw.races
    LEFT JOIN uci_road_raw.country_mappings
        ON races.country = country_mappings.ioc_code
    ORDER BY iso_code
)
INSERT INTO uci_road.countries (iso_code, ioc_code, name, geom)
SELECT
    race_countries.iso_code,
    race_countries.ioc_code,
    COALESCE(countries.name_en, sovereign_states.name_en, units.name_en) AS name,
    COALESCE(countries.geom, sovereign_states.geom, units.geom) AS geom
FROM race_countries
LEFT JOIN uci_road_raw.countries
    ON race_countries.iso_code = countries.adm0_a3
LEFT JOIN uci_road_raw.sovereign_states
    ON
        countries.gid IS null
        AND race_countries.iso_code = sovereign_states.adm0_a3
LEFT JOIN uci_road_raw.units
    ON
        countries.gid IS null
        AND sovereign_states.gid IS null
        AND race_countries.iso_code = units.adm0_a3;

COMMIT;
