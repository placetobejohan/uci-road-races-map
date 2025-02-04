SELECT json_data -> 'items'
FROM
    races_raw;

-- Figure out the data structure
SELECT jsonb_array_elements(json_data -> 'items' -> 1 -> 'items') AS races_on_day
FROM
    races_raw;

-- Use JSON_TABLE to extract the data
SELECT
    json_data,
    name,
    country,
    competition_ts
FROM
    races_raw,
    json_table(
        json_data,
        '$[*].items[*].items[*].items[*]' columns(
            name text path '$.name',
            country char(3) path '$.country',
            details_link text path '$.detailsLink.url',
            competition_ts text path '$.competitionDate'
        )
    );

-- Can we use competitionDate for all the items?
SELECT
    json_data,
    competition_date,
    name,
    country,
    details_link
FROM
    races_raw,
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
    );

-- Now use a CTE first, then group by name and keep only the first and last competition_date
-- Options for the date in the model:
-- 1. start date and end date in a separate column
-- 2. start date and end date in a single column (use range?)
