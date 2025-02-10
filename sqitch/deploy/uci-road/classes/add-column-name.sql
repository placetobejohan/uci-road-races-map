-- Deploy uci-road-races-map:uci-road/classes/add-column-name to pg
-- requires: uci-road/classes/create-table
-- requires: uci-road-raw/filters

BEGIN;

ALTER TABLE uci_road.classes ADD COLUMN name text;

WITH filter_classes AS (
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
    WHERE label = 'Class'
)
UPDATE uci_road.classes
SET name = filter_classes.name
FROM filter_classes
WHERE classes.code = filter_classes.code;

ALTER TABLE uci_road.classes ALTER COLUMN name SET NOT NULL;

COMMIT;
