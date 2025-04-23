import os
import psycopg
import sqlite_utils

# --- Config ---
PG_CONN_STR = "dbname=pro_cycling user=postgres password=postgres host=localhost"
PG_SCHEMA = "uci_road"
SQLITE_DB_PATH = "data/uci_road.db"
# ----------------

# Remove the existing sqlite file
if os.path.exists(SQLITE_DB_PATH):
    os.remove(SQLITE_DB_PATH)

pg_conn = psycopg.connect(PG_CONN_STR)
pg_cur = pg_conn.cursor()
pg_cur.execute(f"SET search_path TO {PG_SCHEMA}")
sqlite_db = sqlite_utils.Database(SQLITE_DB_PATH)

pg_cur.execute(
    f"SELECT table_name FROM information_schema.tables WHERE table_schema = %s",
    (PG_SCHEMA,),
)
tables = [row[0] for row in pg_cur.fetchall()]

for table_name in tables:
    # Get column names
    pg_cur.execute(
        f"SELECT column_name FROM information_schema.columns WHERE table_schema = %s AND table_name = %s",
        (PG_SCHEMA, table_name),
    )
    columns = [row[0] for row in pg_cur.fetchall()]

    # Build SELECT clause, replacing geometry with ST_AsGeoJSON
    select_parts = []
    for col in columns:
        if col == "geom":
            select_parts.append(f"postgis.st_asgeojson({col}) AS {col}")
        else:
            select_parts.append(col)
    select_clause = ", ".join(select_parts)

    pg_cur.execute(f"SELECT {select_clause} FROM {table_name}")
    rows = pg_cur.fetchall()
    colnames = [desc[0] for desc in pg_cur.description]
    data = [dict(zip(colnames, row)) for row in rows]

    print(f"Inserting {len(data)} rows into {table_name}")
    sqlite_db[table_name].insert_all(data, pk="id")

print("Done.")
