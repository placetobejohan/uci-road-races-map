-- Deploy uci-world-tour-map:tables/races to pg
-- requires: appschema
-- requires: tables/races_raw

BEGIN;

-- XXX Add DDLs here.
CREATE TABLE uci_world_tour.races AS
SELECT
    name,
    country,
    'https://www.uci.org' || details_link AS uci_url,
    min(competition_date) AS start_date,
    max(competition_date) AS end_date
FROM
    uci_world_tour.races_raw,
    json_table(
        json_data,
        '$[*].items[*].items[*]' columns(
            competition_date date path '$.competitionDate',
            nested path '$.items[*]' columns(
                name text path '$.name',
                country char(3) path '$.country',
                details_link text path '$.detailsLink.url'
            )
        )
    )
GROUP BY name, country, details_link;

COMMIT;
