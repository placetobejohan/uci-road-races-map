-- Deploy uci-road-races-map:uci-road/categories/add-column-name to pg
-- requires: uci-road/categories/create-table
-- requires: uci-road-raw/filters

BEGIN;

ALTER TABLE uci_road.categories ADD COLUMN name text;

WITH filter_categories AS (
    SELECT
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
    WHERE label = 'Category'
)
UPDATE uci_road.categories
SET name = filter_categories.name
FROM filter_categories
WHERE categories.code = filter_categories.code;

ALTER TABLE uci_road.categories ALTER COLUMN name SET NOT NULL;

COMMIT;
