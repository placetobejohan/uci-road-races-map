-- Deploy uci-world-tour-map:races_raw to pg
-- requires: appschema
BEGIN;

CREATE TABLE uci_world_tour.races_raw (
    id bigint GENERATED ALWAYS AS IDENTITY,
    request_url text not null,
    timestamp timestamptz NOT NULL DEFAULT now(),
    json_data jsonb NOT NULL
);

COMMIT;

